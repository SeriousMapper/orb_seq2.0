extends Node2D
class_name Note
var gravity = Vector2.ZERO
var spawn_position = Vector2.ZERO
var desired_position = Vector2.ZERO
var dist_to_target
var time = 1.0
var last_pos_diff = Vector2.ZERO
var dist = 0
var audio_controller
var beat = 0.0
var beats_advance = 0.0
var speed
onready var tween = $Tween
func _ready():
	dist = position.distance_to(desired_position)
	spawn_position = position
	desired_position = gravity * 32
	
	dist_to_target = position.distance_to(desired_position)
	speed = dist_to_target/2.0
#	tween.interpolate_property(self, "modulate:a", 0.0, 1.0 , 0.0, Tween.TRANS_LINEAR)
#	tween.start()
#	yield(get_tree().create_timer(0.1),"timeout")
#	var dist_mod = position.distance_to(Vector2.ZERO)/dist
#	tween.interpolate_property(self, "modulate:a", 1.0, 0.0 , time, Tween.TRANS_LINEAR)
#	tween.start()
#	yield(tween, "tween_completed")
#	queue_free()
func _process(delta):
	position -= gravity * speed * delta
	if position.distance_to(Vector2.ZERO) < 2:
		queue_free()
