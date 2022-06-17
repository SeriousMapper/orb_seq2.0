extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var tracks = {}
var track_names = []
onready var track_artist = get_node("Circle/track/VBoxContainer/HBoxContainer/VBoxContainer/artist")
onready var track_title = get_node("Circle/track/VBoxContainer/HBoxContainer/VBoxContainer/track_title")
onready var track_difficulty = get_node("Circle/track/VBoxContainer/PanelContainer/hbox/value/difficulty")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RadialMenu.connect("button_selected", self, "button_selected")
	$RadialMenu.connect("button_pressed", self, "button_pressed")
	get_tracks()
	$RadialMenu.buttons = track_names
func get_tracks():
	Globals.load_from_file()
	tracks = Globals.tracks
	var keys = tracks.keys()
	for key in keys:
		track_names.append(key)
func button_selected(btn):
	track_title.text = btn
	track_artist.text = tracks[btn]["artist"]
	track_difficulty.text = get_difficulty(btn)
func button_pressed(btn):
	Player.current_song = tracks[btn]
	
	var difficulty = tracks[btn]["json"].keys()[0]
	Player.current_difficulty = difficulty
	SceneChanger.change_scene("res://scenes/game.tscn")
func get_difficulty(title):
	var difficulties = tracks[title]["json"].keys()
	var string = ""
	for key in difficulties:
		for i in int(key):
			string += "0"
	return string

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
