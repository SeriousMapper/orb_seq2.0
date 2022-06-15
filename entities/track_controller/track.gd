extends Node2D
const note = preload("res://entities/note.tscn")
const long_note = preload("res://entities/note/long_note.tscn")
const dummy_note = preload("res://entities/note/time_measure.tscn")
var beats_shown_in_advance = 6.0
export var latency_mod = 0.12
var notes = []
var note_index = 0
var look_ahead = 0.5
var time = 0
var speed = 0.8
var midi = [36,37,38,39]
var bpm = 1.0
var current_beat = 1.0
var secs_per_beat = 0
var beat_tick = 0.0
var next_beat = 0
var spawn = [Vector2(0,-1), Vector2(1,0), Vector2(0,1), Vector2(-1,0)]
var file_path = "res://tracks/heaven.json"
var unit_per_measure = 0.0
var node_ref = [null,null]
var reference = false
signal quarter_note


var time_delay
var time_begin
func _ready():
	var track_json = load_json()
	notes = track_json.tracks[1].notes
	bpm = track_json.header.bpm
	#print(bpm)
	set_process(false)
	yield(get_tree().create_timer(3.0),"timeout")
	HUD.play_song_intro("H E A V E N", "audisigl", str(int(bpm)) + " BPM")
	yield(get_tree().create_timer(3.0),"timeout")
	set_process(true)
	secs_per_beat = 60.0/bpm
	#time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
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
	current_beat = time/secs_per_beat
	

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
		var new_note
		if notes[note_index].duration > 0.7:
			new_note = long_note.instance()
			new_note.speed_per_unit = unit_per_measure
			
		else:
			
			new_note = note.instance()
		new_note.audio_controller = self
		new_note.beat = note_time
		new_note.beat_at_spawn = current_beat
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

func get_beat():
	pass

func load_json():
	var file = File.new()
	file.open(file_path, File.READ)
	var data = parse_json(file.get_as_text())
	var file_data = data
	return file_data




