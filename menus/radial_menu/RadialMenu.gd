extends Control


var radius = 220
var origin = Vector2(rect_size.x, rect_size.y/2)
var buttons = 9
var rotation = 270
var start_rotation = 180
var draw_ahead = 6
var center_button = buttons/2 + 1
var current_index = 0
var button_nodes = []
func _ready() -> void:
	draw_buttons()
	button_nodes[center_button].grab_focus()
	
func draw_buttons():
	create_buttons(1)



func create_buttons(rev):
	rotation = start_rotation
	for i in buttons:
		rotation += 15 * rev
		var btn = create_button(str(i) + " orb _sec")
		button_nodes.append(btn)
		add_child(btn)
		current_index = current_index + 1 % buttons

func create_button(text):
	var btn = Button.new()
	var point = Vector2(radius * sin(deg2rad(rotation)),radius * cos(deg2rad(rotation)))
		
	btn.rect_position = origin + point
	btn.text = str(current_index)  + " ORB  SEQ"
	return btn
