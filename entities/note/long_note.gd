extends Node2D



var unit_per_measure= 0.0
var start_pos = 0.0
var end_pos = 0.0
var gravity = Vector2.ZERO
var spawn_position = Vector2.ZERO
var desired_position = Vector2.ZERO
var dummy_position = Vector2.ZERO
var hit = false
var audio_controller
var beat = 0.0
var beats_advance = 0.0
var beat_at_spawn = 0.0
var duration = 0.0
var end_position = Vector2.ZERO
var last_position = Vector2.ZERO
var next_position = Vector2.ZERO
var speed_per_unit = 0.0
var tail_length = 0.0
var caught = false
var position_speed = Vector2.ZERO
var go_gray = false
var tick = 0.1
var time = 0
var accuracy = 0.0
var hit_state = false
var beat_duration = 0.0
var beat_mod = 0.0
func _ready() -> void:
	add_to_group("long_notes")
	add_to_group("notes")
	spawn_position = position
	desired_position = gravity * 16
	last_position = position
	beat_duration = beat + duration
	tail_length = (duration) * speed_per_unit
	$Line2D.points[1] = tail_length * gravity
	$end.position = tail_length * gravity
	$end_area.position = tail_length * gravity
	$Label.rect_position = $end.position + $Label.rect_position

func key_released():
	hit = false
	go_gray = true
	beat_mod = duration
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
func calculate_accuracy() -> float:
	var acc = 0.0
	
	acc = ((beat+beat_mod)-audio_controller.current_beat) * audio_controller.secs_per_beat
	print("Accuracy: " + str(acc))
	return acc
func _process(delta):
	end_position = position + $end.position
	var t = (beat-audio_controller.current_beat)/beats_advance
	$Label.text = str(t)
	dummy_position = desired_position.linear_interpolate(spawn_position, t)
	position = position.linear_interpolate(dummy_position, delta * 5)
	if go_gray:
		modulate = modulate.linear_interpolate(Color(1,1,1,0.2), delta * 20)
	if position.distance_to(Vector2.ZERO) < 8 && !hit:
		go_gray = true
		Player.note_accuracy.append(0.0)
		
	if end_position.distance_to(Vector2.ZERO) < 32:
		modulate.a = lerp(modulate.a, 0.0, delta * 10)
		if modulate.a < 0.05 or end_position.distance_to(Vector2.ZERO) < 8:
			if !hit_state:
				Player.remove_combo()
			queue_free()
	if hit:
		if !hit_state:
			$area.queue_free()
			hit_state = true
			
		time += delta
		if time > tick:
			Player.combo += 1
			
			Player.score += Player.combo_multiplier * 5
			Player.combo_multiplier += 0.01
			time = 0
	position_speed = last_position.distance_to(position)
	if caught:
		tail_length = (duration) * speed_per_unit
		$Line2D.points[0] = $Line2D.points[0] + position_speed * gravity
		$start.position = $Line2D.points[0] + position_speed * gravity
	last_position = position

	
	
	

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.linear_interpolate(p1, t)
	var q1 = p1.linear_interpolate(p2, t)
	var r = q0.linear_interpolate(q1, t)
	return r



