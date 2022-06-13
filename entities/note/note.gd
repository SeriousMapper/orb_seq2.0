extends Node2D
class_name Note
var gravity = Vector2.ZERO
var spawn_position = Vector2.ZERO
var desired_position = Vector2.ZERO
var dummy_position = Vector2
var dist_to_target
var time = 1.0
var last_pos_diff = Vector2.ZERO
var dist = 0
var audio_controller
var beat = 0.0
var beats_advance = 0.0
var speed
var bpm_ratio = 0.0
var hit = false
onready var tween = $Tween

func _ready():
	dist = position.distance_to(desired_position)
	spawn_position = position
	desired_position = gravity * 30
	
	dist_to_target = position.distance_to(desired_position)
	speed = dist_to_target/2
#	tween.interpolate_property(self, "modulate:a", 0.0, 1.0 , 0.0, Tween.TRANS_LINEAR)
#	tween.start()
#	yield(get_tree().create_timer(0.1),"timeout")
#	var dist_mod = position.distance_to(Vector2.ZERO)/dist
#	tween.interpolate_property(self, "modulate:a", 1.0, 0.0 , time, Tween.TRANS_LINEAR)
#	tween.start()
#	yield(tween, "tween_completed")
#	queue_free()
func _process(delta):
	var t = (beat-audio_controller.current_beat)/beats_advance
	$Label.text = str(t)
	position = desired_position.linear_interpolate(spawn_position, t)
	if position.distance_to(Vector2.ZERO) < 32:
		modulate.a = lerp(modulate.a, 0.0, delta * 10)
		if modulate.a < 0.05 or position.distance_to(Vector2.ZERO) < 4:
			queue_free()
	if hit:
		queue_free()

	
