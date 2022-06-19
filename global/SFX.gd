extends Node
const MAX_VOLUME = 0.0
const MIN_VOLUME = -72

var button_press = "res://assets/sfx/button_press.wav"
var button_select = "res://assets/sfx/button_select.wav"
var new_menu = "res://assets/sfx/swipe_menu.wav"

func _ready() -> void:
	$MenuMusic.playing = false
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

		
