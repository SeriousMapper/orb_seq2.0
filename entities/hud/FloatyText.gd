extends Node2D


var text = ""
func _ready():
	$Label.text = text
	$AnimationPlayer.play("popup")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
