extends CanvasLayer

const floaty_text = preload("res://entities/hud/FloatyText.tscn")
onready var song_display = get_node("song_display")
func _ready():
	song_display.visible = false 
	$song_intro.visible = false

func spawn_floaty_text(position, text):
	var _floaty = floaty_text.instance()
	_floaty.global_position = position
	_floaty.text = text
	$hud_display.add_child(_floaty)
	
func play_song_intro(artist, title, bpm):
	song_display.visible = true
	$song_intro.visible = true
	$song_intro.play_text(artist, title, bpm)
