extends Node2D


const sprite_size = 16
var time = 0
export var orbit_scale = Vector2(12,4)
var orb_pos = Vector2.ZERO
export var offset  = 4
export var speed = 0.2
func _ready() -> void:
	orb_pos = Vector2(sin(0), cos(0)) * sprite_size * orbit_scale
	
func _process(delta: float) -> void:
	$ball.position = orb_pos
	$orbit.scale = orbit_scale
	time = Globals.track_time
	var rot_time = time/Globals.secs_per_beat/offset
	rotation_degrees = sin(rot_time * speed) * 15
	orb_pos = Vector2(sin(rot_time) * sprite_size * orbit_scale.x, cos(rot_time) * sprite_size * orbit_scale.y)

