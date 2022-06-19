extends Node
const MAX_VOLUME = 0.0
const MIN_VOLUME = -72
var good_vox = []
var bad_vox = []
var neutral_vox = []
var button_press = "res://assets/sfx/button_press.wav"
var button_select = "res://assets/sfx/button_select.wav"
var new_menu = "res://assets/sfx/swipe_menu.wav"
var greer_pack = "res://assets/sfx/dr_greer/"
func _ready() -> void:
	$MenuMusic.playing = false
	read_folder(greer_pack)
	print(good_vox)
func play_random(arr):
	$Vox.stream = load(arr[randi()%arr.size()])
	$Vox.play()
func play_sound_ui(sound):
	$UI.stream = load(sound)
	$UI.play()
	
func fade_out_music():
	
	$Tween.interpolate_property($MenuMusic,"volume_db", $MenuMusic.volume_db, -92.0, 6.0,Tween.TRANS_LINEAR)
	$Tween.start()
	yield($Tween, "tween_completed")
	$MenuMusic.playing = false
func fade_in_music():
	$MenuMusic.playing = true
	$Tween.interpolate_property($MenuMusic,"volume_db", $MenuMusic.volume_db, -6.0, 1.0,Tween.TRANS_LINEAR)
	$Tween.start()

func read_folder(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.ends_with(".ogg"):
					match file_name[0]:
						"G":
							good_vox.append(path+file_name)
						"B":
							bad_vox.append(path+file_name)
						"N":
							neutral_vox.append(path+ file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
