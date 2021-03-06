extends CanvasLayer

const floaty_text = preload("res://entities/hud/FloatyText.tscn")
onready var song_display = get_node("song_display")
var combo_visible = false
func _ready():
	song_display.visible = false 
func hide_display():
	song_display.visible = false 
func spawn_floaty_text(position, text):
	var _floaty = floaty_text.instance()
	_floaty.global_position = position
	_floaty.text = text
	$hud_display.add_child(_floaty)
	
func play_song_intro(artist, title, bpm):
	song_display.visible = true
	$song_intro.play_text(artist, title, bpm)
func add_tick_to_combo():
	$hud_display.vibrate_tick = 0.0
func show_combo_box():
	$hud_display.show_combo_counter()
	combo_visible = true
func hide_combo_box():
	$hud_display.hide_combo_counter()
	combo_visible = false
