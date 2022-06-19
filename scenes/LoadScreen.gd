extends Control

var track_directory = "res://track_folder/"
var tracks = {}
func _ready() -> void:
	yield(get_tree(),"idle_frame")
	dir_contents(track_directory) 
	
func dir_contents(path):
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				read_folder(path+file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	#Globals.save("res://user_data/tracks_import.save", tracks)
	
	Globals.tracks = Globals.load_from_file("res://user_data/tracks_import.save")
	Player.load_player_data()
	yield(get_tree().create_timer(1),"timeout")
	SceneChanger.change_scene("res://scenes/MainMenu.tscn")
func read_folder(path):
	var dir = Directory.new()
	var track_dict = {"cover": "","json": {}, "mp3_path": "", "artist": "", "bpm": 0, "track_name": ""}
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.ends_with(".json"):
					var json = load_json(path+"/"+file_name)
					var _header = json.header
					track_dict["json"][_header.difficulty] = path+"/"+file_name
					track_dict["artist"] = _header.artist
					track_dict["bpm"] = int(_header.bpm)
					track_dict["track_name"] = _header.name
				if file_name.ends_with(".mp3"):
					track_dict["mp3_path"] = path+"/"+file_name
				if file_name.ends_with(".png") or file_name.ends_with(".jpg"):
					track_dict["cover"] = path+"/"+file_name
				
					
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	tracks[track_dict.track_name] = track_dict
func load_json(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	var data = parse_json(file.get_as_text())
	var file_data = data
	return file_data

