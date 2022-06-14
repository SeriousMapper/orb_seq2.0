extends Node2D


var beat = 0.0
var audio_controller
var beats_advance
var dummy_position = Vector2.ZERO
var spawn_position = Vector2.ZERO
var desired_position = Vector2.ZERO
var gravity = Vector2(0,-1)
func _ready() -> void:
	spawn_position = position
	desired_position = gravity * 32
func _process(delta: float) -> void:
	var t = (beat-audio_controller.current_beat)/beats_advance
	dummy_position = desired_position.linear_interpolate(spawn_position, t)
	position = position.linear_interpolate(dummy_position, delta * 5)
