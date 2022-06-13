extends Sprite
enum states {NONE, OKAY, GOOD, PERFECT}
var state = states.NONE
var input = Vector2.ZERO
var active = false
var just_pressed = false
var mod = Color(1,1,1,0.5)
var just_pressed_timer = 0.1
var time = 0
var scale_mod = Vector2(1,1)
func _ready():
	pass 

func _process(delta):
	if active:
		mod = Color(0.6,0.6, 1.0, 0.8)
	else:
		mod = Color(1,1,1,0.5)
	if just_pressed:
		time += delta
		if time > just_pressed_timer:
			just_pressed = false
			time = 0
			print("just pressed!")
	modulate = modulate.linear_interpolate(mod, delta * 5)

func _process_note():
	if just_pressed:
		var text = ""
		match state:
			states.PERFECT:
				text = "Perfect!"
			states.OKAY:
				text = "Okay"
			states.GOOD:
				text = "Good!"
		if text != "":
			HUD.spawn_floaty_text(global_position, text)
		just_pressed = false
		state = states.NONE
		time = 0
		print(text)
		




func _on_Perfect_area_entered(area):
	if area.get_parent() is Note:
		state = states.PERFECT
		_process_note()


func _on_Good_area_entered(area):
	if area.get_parent() is Note:
		state = states.GOOD

		_process_note()


func _on_Okay_area_entered(area):
	if area.get_parent() is Note:
		state = states.OKAY
		_process_note()
