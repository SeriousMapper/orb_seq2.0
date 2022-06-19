extends PanelContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var album_cover = get_node("VBoxContainer/PanelContainer2/VBoxContainer/album_cover")
onready var track_title = get_node("VBoxContainer/PanelContainer2/VBoxContainer/track_title")
onready var track_artist = get_node("VBoxContainer/PanelContainer2/VBoxContainer/track_artist")

onready var track_score = get_node("VBoxContainer/PanelContainer/HBoxContainer/TrackScore")
onready var track_quality = get_node("VBoxContainer/TrackQuality")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_track = Player.current_song
	track_title.text = current_track["track_name"]
	track_artist.text = current_track["artist"]
	var _track_quality = Player.get_track_quality()
	track_score.text = _track_quality[0]
	track_quality.text = _track_quality[1]
	$VBoxContainer/PanelContainer2/VBoxContainer/album_cover.texture = load(Player.current_song['cover'])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
