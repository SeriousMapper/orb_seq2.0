extends Node2D
const note = preload("res://entities/note.tscn")
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
func _ready():
	var track_json = load_json()
	notes = track_json.tracks[0].notes
	bpm = track_json.header.bpm
	secs_per_beat = 60.0/bpm
	print(bpm, " ", secs_per_beat)
	yield(get_tree().create_timer(speed),"timeout")
	$Player.play()
func _physics_process(delta):
	time = $Player.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	
	current_beat = time/secs_per_beat
	current_beat = stepify(current_beat, 0.25) + 4.0
	var note_time = stepify(notes[note_index].time/secs_per_beat, 0.25)
	
	if current_beat >= note_time:
		var midi_key = int(notes[note_index].midi)
		var midi_index = midi.find(midi_key)
		
		var new_note = note.instance()
		new_note.time = 0.1
		new_note.gravity = spawn[midi_index]
		new_note.position = spawn[midi_index] * 200
		add_child(new_note)
		note_index += 1
	if note_index >= notes.size() - 1:
		set_process(false)
func get_beat():
	pass

func load_json():
	var file = File.new()
	file.open(file_path, File.READ)
	var data = parse_json(file.get_as_text())
	var file_data = data
	return file_data




