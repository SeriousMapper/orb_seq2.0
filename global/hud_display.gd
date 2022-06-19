extends Control
const vibrate_time = 0.2
var vibrate_tick = 0.0

var time = 0
func _ready() -> void:
	$combo_counter.rect_position.y = 100
	$combo_counter.modulate.a = 0.0
func _process(delta: float) -> void:
	time += delta
	$combo_counter/PanelContainer/VBoxContainer/value.text = str(Player.combo)
	vibrate_tick += delta
	if vibrate_tick < vibrate_time:
		$combo_counter/PanelContainer.rect_position.y = sin(time * 30.0) * 2.0 + 100

func show_combo_counter():
	$Tween.interpolate_property($combo_counter, "rect_position:y", $combo_counter.rect_position.y, 0, 1.0,Tween.TRANS_CUBIC)
	$Tween.interpolate_property($combo_counter, "modulate:a", $combo_counter.modulate.a, 1.0, 1.0,Tween.TRANS_CUBIC)
	$Tween.start()
func hide_combo_counter():
	$Tween.interpolate_property($combo_counter, "rect_position:y", $combo_counter.rect_position.y, 100, 1.0,Tween.TRANS_CUBIC)
	$Tween.interpolate_property($combo_counter, "modulate:a", $combo_counter.modulate.a, 0.0, 1.0,Tween.TRANS_CUBIC)
	$Tween.start()
