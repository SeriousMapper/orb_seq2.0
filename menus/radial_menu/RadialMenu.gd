extends Control

const MAX_SWIPE_SPEED = 0.4
const MIN_SWIPE_SPEED = 0.1
var radius = 250
var origin = Vector2(rect_size.x, rect_size.y/2)
var rotation = 270
var start_rotation = 180

var buttons = ["Quick_Play", "Career", "Stats",'Settings', "Calibration", "Leaderboards"]
var button_info = [
	"Play a favorite song, or pursue the leaderboards!",
	"From rags to riches, propel yourself to the best amongst the top 100 DJs.",
	"Look at your stats, such as gameplay time or accuracy.",
	"Adjust the settings to your desired needs.",
	"Calibrate your system to reduce latency when playing songs.",
	"View the leaderboards throughout the world and see where you belong!"
]
var draw_ahead = 18
var center_button = 5
var selected_button = center_button
var current_index = 0
var button_nodes = []
var button_positions = []
var matrix = null
var cont = true
var swipe_speed = MAX_SWIPE_SPEED
onready var tween = get_node("Tween")

onready var info_title = get_node("Info/vbox/name")
onready var info = get_node("Info/vbox/info")
func _ready() -> void:
	draw_buttons()
	print(button_positions)
	matrix = MatrixText.new("Hello", info)
	print((current_index + button_nodes.size()-1) % button_nodes.size())
	button_nodes[center_button].grab_focus()

func _process(delta) -> void:
	if cont:
		swipe_speed = lerp(swipe_speed, MAX_SWIPE_SPEED, delta)
		if Input.is_action_pressed("ui_up"):
			_rotate_buttons(1)
			
		if Input.is_action_pressed("ui_down"):
			_rotate_buttons(-1)
	else:
		swipe_speed = lerp(swipe_speed, MIN_SWIPE_SPEED, delta)
	print(swipe_speed)
func draw_buttons():
	create_buttons(1)
	_load_buttons()
	

func _rotate_buttons(by:int):
	cont = false
	for i in button_nodes.size():
		var button = button_nodes[i]
		button.visible = true
		var next_button = button_positions[(i + current_index + by) % button_nodes.size()]
		tween.interpolate_property(button, "rect_position", button.rect_position, next_button, swipe_speed,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		if button.rect_position.distance_to(next_button) > 500:
			button.visible = false
	tween.start()
	yield(tween,"tween_all_completed")
	
	
	current_index += by
	selected_button = (center_button - current_index) % button_nodes.size()
	button_nodes[(selected_button+by) % button_nodes.size()].grab_focus()
	info_title.text = buttons[(selected_button+1) % buttons.size()]
	matrix.queue_free()
	matrix = MatrixText.new(button_info[(selected_button+1) % buttons.size()], info)
	_load_buttons()
	yield(get_tree(),"idle_frame")
	cont = true
	button_nodes[(selected_button) % button_nodes.size()].grab_focus()
	
func _load_buttons():
	for i in button_nodes.size():
		button_nodes[i].text = buttons[(i-selected_button - current_index) % buttons.size()]
		
func create_buttons(rev):
	rotation = start_rotation
	for i in draw_ahead:
		rotation += 15 * rev
		var btn = create_button(str(i) + " orb _sec")
		button_nodes.append(btn)
		button_positions.append(btn.rect_position)
		add_child(btn)

func create_button(text):
	var btn = Button.new()
	var point = Vector2(radius * sin(deg2rad(rotation)),radius * cos(deg2rad(rotation)))
	btn.rect_min_size = Vector2(100,-32)
	btn.rect_position = origin + point
	btn.text = str(current_index)  + " ORB  SEQ"
	return btn
