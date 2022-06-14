extends Node2D
signal unactive()
enum states {NONE, OKAY, GOOD, PERFECT}
var state = states.NONE
var input = Vector2.ZERO
var active = false
var long_active = false
var just_pressed = false
var mod = Color(1,1,1,0.5)
var just_pressed_timer = 0.10
var time = 0
var scale_mod = Vector2(0.5,0.5)
var circ2_mod = 0
var circ2_scale_mod = Vector2(0.5,0.5)
var colliding = true
onready var circle = get_node("Circle")
onready var circ2 = get_node("Circle2")
onready var tween = get_node("Tween")
func _ready():
	pass 

func _process(delta):

	$Okay.monitoring = colliding

	$Good.monitoring = colliding
	$Perfect.monitoring = colliding
	$Particles2D.emitting = long_active && active
	if active:
		mod = Color(0.7,0.7, 1.0, 0.9)
		scale_mod = Vector2(1,1)
	else:
		mod = Color(1,1,1,0.5)
		if long_active:
			long_active = false
			emit_signal("unactive")
			time = 0
			just_pressed = true
		scale_mod = Vector2(0.5,0.5)
		
	if just_pressed:
		time += delta
		colliding = true

		if time > just_pressed_timer:
			just_pressed = false
			colliding = false
			time = 0
			print("just pressed!")
	circle.modulate = circle.modulate.linear_interpolate(mod, delta * 5)
	circle.scale = circle.scale.linear_interpolate(scale_mod, delta * 5)

		
func _process_note(note):
	print(note.hit, just_pressed)
	if just_pressed && note.hit == false:
		var text = ""
		note.hit = true
		var accuracy = 0.0
		if note.is_in_group("long_notes"):
			connect("unactive", note, "key_released")
			long_active = true
			print("long note!")
		match state:
			states.PERFECT:
				text = "Perfect!"
				Player.perfect += 1
				accuracy = 1.0
			states.OKAY:
				text = "Okay"
				Player.okay += 1
				accuracy = 0.7
			states.GOOD:
				text = "Good!"
				Player.good += 1
				accuracy = 0.8
		if text != "":
			Player.add_combo()
			HUD.spawn_floaty_text(global_position, text)
			circle.modulate = Color(1.2,1.2,1.2,1.0)
		else:
			accuracy = 0.0
		
		Player.note_accuracy.append(accuracy)
		state = states.NONE
		
		

func _on_Perfect_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("notes"):
		
		state = states.PERFECT
		_process_note(area.get_parent())


func _on_Good_area_entered(area):
	print("collding!")
	var body = area.get_parent()
	if body.is_in_group("notes"):
		state = states.GOOD
		tween.interpolate_property(circ2, "modulate:a", circ2.modulate.a, 0.1, 0.3,Tween.TRANS_CUBIC)
		tween.interpolate_property(circ2, "scale", circ2.scale, Vector2(1.2,1.2), 0.3,Tween.TRANS_CUBIC)
		tween.start()
		_process_note(area.get_parent())

func _on_Okay_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("notes"):
		state = states.OKAY
#		tween.interpolate_property(circ2, "modulate:a", circ2.modulate.a, 0.1, 0.3,Tween.TRANS_CUBIC)
#		tween.interpolate_property(circ2, "scale", circ2.scale, Vector2(1.2,1.2), 0.3,Tween.TRANS_CUBIC)
#		tween.start()
		_process_note(area.get_parent())


func _on_Okay_area_exited(area):
	pass


func _on_Good_area_exited(area):
	var body = area.get_parent()
	if body.is_in_group("notes"):
		tween.stop_all()
		tween.interpolate_property(circ2, "modulate:a", circ2.modulate.a, 0.0, 0.1,Tween.TRANS_CUBIC)
		tween.interpolate_property(circ2, "scale", circ2.scale, Vector2(0.5,0.5), 0.1,Tween.TRANS_CUBIC)
		tween.start()


func _on_LongCatch_area_entered(area: Area2D) -> void:
	area.get_parent().caught = true
		
