extends Node2D
signal note_hit(x) #bool if note is hit or not
signal boss_note_warning(pos)
signal boss_note_pos(pos)
const note = preload("res://entities/note.tscn")
const long_note = preload("res://entities/note/long_note.tscn")
const dummy_note = preload("res://entities/note/time_measure.tscn")

var beats_shown_in_advance = 6.0
export var latency_mod = 0.12
var current_track = {"artist":"9Hour", 
"bpm":107, 
"json":{6:"res://track_folder/arrithmia/track3.json"}, 
"mp3_path":"res://track_folder/arrithmia/track3.mp3", 
"track_name":"Arrithmia"}
var current_diff = 6
var boss_battle = false
var notes = []
var note_index = 0
var look_ahead = 0.5
var time = 0
var speed = 0.8
var midi = [36,37,38,39,41,42,43,44]
var boss_notes = [41,42,43,44]
var bpm = 1.0
var current_beat = 1.0
var secs_per_beat = 0
var beat_tick = 0.0
var next_beat = 0
var spawn = [Vector2(0,-1), Vector2(1,0), Vector2(0,1), Vector2(-1,0),Vector2(0,-1), Vector2(1,0), Vector2(0,1), Vector2(-1,0)]
var file_path = "res://tracks/heaven.json"
var unit_per_measure = 0.0
var node_ref = [null,null]
var reference = false
signal quarter_note
signal song_done
var spec_index = 0
var spec_time = 0

var boss_pos = []
var boss_beat = []
var time_delay
var time_begin
func _ready():
	SFX.fade_out_music()
	yield(get_tree(),"idle_frame")
	if Player.current_song.keys().size() > 0:
		current_track = Player.current_song
		current_diff = Player.current_difficulty
	print(current_track)
	file_path = current_track['json'][current_diff]
	$Player.stream = load(current_track['mp3_path'])
	var track_json = load_json()
	notes = track_json.tracks[1].notes
	bpm = track_json.header.bpm
	#print(bpm)
	set_process(false)
	yield(get_tree().create_timer(3.0),"timeout")
	var artist = current_track['artist']
	var track_title = current_track['track_name']
	HUD.play_song_intro(track_title, artist, str(int(bpm)) + " BPM")
	yield(get_tree().create_timer(2.0),"timeout")
	set_process(true)
	secs_per_beat = 60.0/bpm
	Globals.secs_per_beat = secs_per_beat
	#time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	print("Time delay   " + str(time_delay))
	#print(secs_per_beat/beats_shown_in_advance)
	#print(bpm, " ", secs_per_beat)
	$Player.play()
func _spawn_dummy():
	var dummy = dummy_note.instance()
	dummy.beat = current_beat + beats_shown_in_advance
	dummy.beats_advance = beats_shown_in_advance
	dummy.gravity = spawn[0]
	dummy.position = spawn[0] * 400
	dummy.audio_controller = self
	add_child(dummy)
	node_ref[1] = node_ref[0]
	node_ref[0] = dummy
	if node_ref[1] != null:
		reference = true
	
func _process(delta):
#	time = 0 
#	time = (float((OS.get_ticks_usec() - time_begin)) / 1000000) - latency_mod
#	time -= time_delay
	time = $Player.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	
	time -= latency_mod
	Globals.track_time = time
	current_beat = time/secs_per_beat
	if boss_beat.size() > 0:
		if boss_beat[0] < current_beat:
			emit_signal("boss_note_pos", boss_pos[0])
			boss_pos.remove(0)
			boss_beat.remove(0)

	if current_beat > next_beat:
		next_beat = int(current_beat) + 4
		_spawn_dummy()
		if reference:
			unit_per_measure = node_ref[0].global_position.distance_to(node_ref[1].global_position)/4
			node_ref[1].queue_free()
			
	
	var note_time = 0
	if note_index < notes.size():
		note_time = notes[note_index].time/secs_per_beat
		
	if note_time < current_beat + beats_shown_in_advance && note_time > 0:
		var midi_key = int(notes[note_index].midi)
		var midi_index = midi.find(midi_key)
		if midi_index == -1:
			return
		var new_note
		if notes[note_index].duration > 0.7:
			new_note = long_note.instance()
			new_note.speed_per_unit = unit_per_measure
		else:
			new_note = note.instance()
		new_note.audio_controller = self
		new_note.beat = note_time
		new_note.boss_note = boss_notes.has(midi_key)
		if new_note.boss_note:
			boss_note_warning(spawn[midi_index])
			boss_pos.append(spawn[midi_index])
			boss_beat.append(note_time + 1.0)
		new_note.beat_at_spawn = current_beat
		new_note.connect("note_removed", self, "_note_hit")
		new_note.duration = notes[note_index].duration/secs_per_beat
		new_note.beats_advance = beats_shown_in_advance
		new_note.gravity = spawn[midi_index]
		new_note.position = spawn[midi_index] * 400
		
		# -------------------------------------
		var mod_time = int(stepify(note_time, 0.25) * 100)
		
		if (mod_time % 100 == 0):
			new_note.modulate = Globals.green
			emit_signal("quarter_note")
		elif (mod_time % 50 == 0):
			new_note.modulate = Globals.blue
		elif (mod_time % 25 == 0):
			new_note.modulate = Globals.yellow 
		
		#--------------------------------------
		add_child(new_note)
		note_index += 1
		
	if spec_index < notes.size():
		spec_time = notes[spec_index].time / secs_per_beat
	else:
		spec_time = -1
	if (spec_time < current_beat && spec_time > 0):
		var mod_time = int(stepify(spec_time, 0.25) * 100)
		if (mod_time % 100 == 0):
			emit_signal("quarter_note")
		spec_index += 1
func _show_boss_pos(pos):
	emit_signal("boss_note_pos", pos)
func boss_note_warning(pos):
	emit_signal("boss_note_warning",pos)
func _note_hit(note):
	emit_signal("note_hit", note)
func get_beat():
	pass

func load_json():
	var file = File.new()
	file.open(file_path, File.READ)
	var data = parse_json(file.get_as_text())
	var file_data = data
	return file_data






func _on_Player_finished() -> void:
	emit_signal("song_done")
	HUD.song_display.visible =false
	print("SONG IS DONE")
	SFX.fade_in_music()
