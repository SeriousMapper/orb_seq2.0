extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$controller/track.connect("song_done", self, "song_finished")

func song_finished():
	SceneChanger.change_scene("res://menus/debriefing/debriefing.tscn")
