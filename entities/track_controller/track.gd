extends Node2D
const note = preload("res://entities/note.tscn")
var beats_shown_in_advance = 4.0
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
var spawn = [Vector2(0,-1), Vector2(1,0), Vector2(0,1), Vector2(-1,0)]
var file_path = "res://tracks/track3.json"
signal quarter_note
var spec_index = 0
var spec_time = 0


var time_delay
var time_begin
func _ready():
	var track_json = load_json()
	notes = track_json.tracks[1].notes
	bpm = track_json.header.bpm
	#print(bpm)
	secs_per_beat = 60.0/bpm
	#time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	#print(secs_per_beat/beats_shown_in_advance)
	#print(bpm, " ", secs_per_beat)
	$Player.play()
func _process(delta):
#	time = 0 
#	time = (float((OS.get_ticks_usec() - time_begin)) / 1000000) - latency_mod
#	time -= time_delay
	time = $Player.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	time -= latency_mod
	
	current_beat = time/secs_per_beat
	
	var note_time = 0
	if note_index < notes.size():
		note_time = notes[note_index].time/secs_per_beat
	if note_time < current_beat + beats_shown_in_advance && note_time > 0:
		var midi_key = int(notes[note_index].midi)
		var midi_index = midi.find(midi_key)
		
		var new_note = note.instance()
		new_note.audio_controller = self
		new_note.beat = note_time
		new_note.bpm_ratio = (bpm/60.0)
		new_note.beats_advance = beats_shown_in_advance
		new_note.gravity = spawn[midi_index]
		new_note.position = spawn[midi_index] * 400
		# -------------------------------------
		var mod_time = int(stepify(note_time, 0.25) * 100)
		
		if (mod_time % 100 == 0):
			new_note.modulate = Globals.green
		elif (mod_time % 50 == 0):
			new_note.modulate = Globals.blue
		elif (mod_time % 25 == 0):
			new_note.modulate = Globals.yellow 
		
		#--------------------------------------
		add_child(new_note)
		note_index += 1
		
	#for triggering spectrum analyzer on beat instead of ahead of beat
	if spec_index < notes.size():
		spec_time = notes[spec_index].time / secs_per_beat
	else:
		spec_time = -1
	if (spec_time < current_beat && spec_time > 0):
		var mod_time = int(stepify(spec_time, 0.25) * 100)
		if (mod_time % 100 == 0):
			emit_signal("quarter_note")
		spec_index += 1
func get_beat():
	pass

func load_json():
	var file = File.new()
	file.open(file_path, File.READ)
	var data = parse_json(file.get_as_text())
	var file_data = data
	return file_data




