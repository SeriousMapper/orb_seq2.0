extends Node2D
const note = preload("res://entities/note.tscn")
const beats_shown_in_advance = 4.0
export var latency_mod = 800.0
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
var file_path = "res://tracks/test_track.json"


var time_delay
var time_begin
func _ready():
	var track_json = load_json()
	notes = track_json.tracks[0].notes
	bpm = track_json.header.bpm
	secs_per_beat = 60.0/bpm
	time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	print(secs_per_beat/beats_shown_in_advance)
	print(bpm, " ", secs_per_beat)
	$Player.play()
func _process(delta):
	time = 0 
	time = (float((OS.get_ticks_usec() - time_begin)) / 1000000) - latency_mod
	time -= time_delay
#	time = $Player.get_playback_position() + AudioServer.get_time_since_last_mix()
#	# Compensate for output latency.
#	time -= AudioServer.get_output_latency()
	
	current_beat = time/secs_per_beat
	
	current_beat = stepify(current_beat, 0.25)
	var note_time = stepify(notes[note_index].time/secs_per_beat, 0.25)

	
	if note_time < current_beat + beats_shown_in_advance:
		var midi_key = int(notes[note_index].midi)
		var midi_index = midi.find(midi_key)
		
		var new_note = note.instance()
		new_note.time = 0.1
		new_note.audio_controller = self
		new_note.beat = note_time
		new_note.beats_advance = beats_shown_in_advance
		new_note.gravity = spawn[midi_index]
		new_note.position = spawn[midi_index] * 300
		add_child(new_note)
		note_index += 1
	if note_index >= notes.size():
		set_process(false)
func get_beat():
	pass

func load_json():
	var file = File.new()
	file.open(file_path, File.READ)
	var data = parse_json(file.get_as_text())
	var file_data = data
	return file_data




