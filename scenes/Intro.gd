extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("intro")
	yield($AnimationPlayer,"animation_finished")
	var mt = MatrixText.new("GODOT WILD JAM #46", $VBoxContainer/Label)
	yield(get_tree().create_timer(2),"timeout")
	$AnimationPlayer.play("fade")
	SceneChanger.change_scene("res://scenes/LoadScreen.tscn")
