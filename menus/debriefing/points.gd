extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()


func _draw():
	for i in get_parent().get_points():
		draw_circle(i, 2.0, Color(1,1,1,1.0))
		print(i)
