extends Node

var tracks_file = "res://user_data/tracks_import.save"
var tracks = {}
var blackholes = []
var green = Color("#dd0000") * 1.25
var blue = Color("#00dd00") * 1.25
var yellow = Color("#0000dd") * 1.25
var spec_num = 2
var latency = 0
var secs_per_beat = 0.5
var track_time = 0.0
func _ready():
	pass
func save(var path : String, var thing_to_save):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_var(thing_to_save, true)
	file.close()
func load_from_file():
	var file = File.new()
	if file.file_exists(tracks_file):
		file.open(tracks_file, File.READ)
		tracks = file.get_var(true)
		file.close()
	print(tracks)
