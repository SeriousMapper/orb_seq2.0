extends Node
const MAX_VOLUME = 0.0
const MIN_VOLUME = -72
var good_vox = ["res://assets/sfx/dr_greer/G - Ancient Masters.mp3",
"res://assets/sfx/dr_greer/G - beyond the speed of light 2.mp3",
"res://assets/sfx/dr_greer/G - Big quantum leap.mp3",
"res://assets/sfx/dr_greer/G - Crystal Clear.mp3",
"res://assets/sfx/dr_greer/G - deep sprituality.mp3",
"res://assets/sfx/dr_greer/G - extraterrestrial.mp3",
"res://assets/sfx/dr_greer/G - Extrmely Enlightened.mp3",
"res://assets/sfx/dr_greer/G - Very Beautiful.mp3"]
var bad_vox = ["res://assets/sfx/dr_greer/B - Dropping Dead.mp3",
"res://assets/sfx/dr_greer/B - I'm really not very hopeful.mp3",
"res://assets/sfx/dr_greer/B - Resonate Higher.mp3",
"res://assets/sfx/dr_greer/B - Near Death Experience.mp3",
"res://assets/sfx/dr_greer/B - The foxes are guarding the hen house.mp3"]
var neutral_vox = ["res://assets/sfx/dr_greer/N - Contact.mp3"]
var button_press = "res://assets/sfx/button_press.wav"
var button_select = "res://assets/sfx/button_select.wav"
var new_menu = "res://assets/sfx/swipe_menu.wav"
var greer_pack = "res://assets/sfx/dr_greer/"
func _ready() -> void:
	$MenuMusic.playing = false
	#read_folder(greer_pack)
	print(good_vox)
func play_random(arr):
	$Vox.stream = load(arr[randi()%arr.size()])
	$Vox.play()
	pass
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
				if file_name.ends_with(".mp3"):
					match file_name[0]:
						"G":
							good_vox.append(load(path+file_name))
						"B":
							bad_vox.append(load(path+file_name))
						"N":
							neutral_vox.append(load(path+file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
