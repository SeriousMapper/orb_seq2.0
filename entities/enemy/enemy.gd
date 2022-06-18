extends Node2D

const max_speed = 20
const min_speed = 0.2
const sprite_size = 16
var time = 0
export var orbit_scale = Vector2(12,4)
var orbit_base = Vector2.ZERO
var orb_pos = Vector2.ZERO
export var offset  = 4
export var speed = 0.2
func _ready() -> void:
	orb_pos = Vector2(sin(0), cos(0)) * sprite_size * orbit_scale
	orbit_base = orbit_scale
	
func _process(delta: float) -> void:
	speed = clamp(max_speed * abs(Player.health-1), min_speed, max_speed)
	orbit_scale  = orbit_scale.linear_interpolate(orbit_base*Player.health, delta)
	$ball.position = orb_pos
	$orbit.scale = orbit_scale
	time += delta * speed
	var rot_time = time/Globals.secs_per_beat/offset
	rotation_degrees = sin(rot_time * 0.2) * 15
	orb_pos = Vector2(sin(rot_time) * sprite_size * orbit_scale.x, cos(rot_time) * sprite_size * orbit_scale.y)

