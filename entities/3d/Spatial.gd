extends Spatial

var time = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	time += delta
	rotate_y(delta)
	
