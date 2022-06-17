extends CanvasLayer
signal faded()

# Declare member variables here. Examples:
# var a: int = 2

func _ready() -> void:
	pass 
func change_scene(scene):
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(scene)
	yield(get_tree().create_timer(0.2),"timeout")
	SFX.play_sound_ui(SFX.new_menu)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer,"animation_finished")
	emit_signal("faded")
