extends Control


var radius = 220
var origin = Vector2(rect_size.x, rect_size.y/2)
var buttons = 4
var rotation = 270
var start_rotation = 270
var draw_ahead = 3
var current_index = 0
var button_nodes = []
func _ready() -> void:
	draw_buttons()
	button_nodes[0].grab_focus()
	
func draw_buttons():
	create_button(1)



func create_button(rev):
	rotation = start_rotation
	for i in draw_ahead:
		var btn = Button.new()
		var point = Vector2(radius * sin(deg2rad(rotation)),radius * cos(deg2rad(rotation)))
		
		btn.rect_position = origin + point
		btn.text = str(current_index)  + " ORB  SEQ"
		rotation += 15 * rev
		button_nodes.append(btn)
		add_child(btn)
		current_index = current_index + 1 % buttons

			
