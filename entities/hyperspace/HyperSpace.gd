extends ColorRect


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var time = 0.0
var time_mod = 0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	time+= delta
	var set = 2.0
	print(set)
	material.set_shader_param("hyperbolic", set)
	material.set_shader_param("time_mod", time_mod)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
