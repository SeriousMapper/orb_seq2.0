extends Node2D


var text = ""
func _ready():
	position += get_viewport_rect().size/2
	
	$Label.text = text
	$AnimationPlayer.play("popup")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
