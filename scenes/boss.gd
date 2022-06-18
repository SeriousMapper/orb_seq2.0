extends Node2D

var hit = false
var hit_time = 0.5
var time = 1.0
var sin_time = 0.0
var lerp_pos = position
var target_pos = Vector2.ZERO
var rot = 0.0
var lerp_rot = 0.0
var emit_time = 0.0
var emit_length = 0.1
var emit = false
func _ready() -> void:
	lerp_pos = $Sprite.position 
func _process(delta: float) -> void:
	sin_time += delta
	lerp_rot = lerp(lerp_rot, rot, delta)
	target_pos = Vector2(sin(lerp_rot), cos(lerp_rot)) * 150
	$Sprite.position = target_pos
	if hit:
		time += delta
		position.x += sin(sin_time * 30.0) * 0.1
		if time > hit_time:
			hit = false
			time = 0.0
	if emit:
		emit_time += delta
		$blast.emitting = true
		$blast.gravity = $Sprite.position
		if emit_time > emit_length:
			emit = false
			$blast.emitting = false
func get_hit():
	hit = true
	time = 0.0
func emit_hit():
	emit = true
	emit_time = 0.0
func set_pos(pos):
	rot = Vector2.UP.angle_to(pos)
func get_pos():
	return $Sprite.position
