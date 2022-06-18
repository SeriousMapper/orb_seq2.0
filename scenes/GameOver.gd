extends Control

var pos_save = Vector2.ZERO
signal pressed(x)
func _ready() -> void:
	modulate.a = 0.0
	$Tween.interpolate_property(self, "rect_position:y", 200, 0, 2.0,Tween.TRANS_CUBIC)
	$Tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 2.0,Tween.TRANS_CUBIC)
	
	$Tween.start()
	yield($Tween,"tween_completed")
	$MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/retry.grab_focus()
	yield(self, "pressed")
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 1.0,Tween.TRANS_CUBIC)
	$Tween.interpolate_property(self, "rect_position:y", 0, -50, 1.0,Tween.TRANS_CUBIC)
	$Tween.start()
func _on_retry_pressed() -> void:
	emit_signal("pressed", "retry")


func _on_quit_pressed() -> void:
	emit_signal("pressed", "quit")
