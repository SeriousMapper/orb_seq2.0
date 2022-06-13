extends Node2D
const CATCH_NUM = 4
enum catch {NONE, UP, LEFT, RIGHT, DOWN}
var catch_state = catch.NONE
var input_pos = [Vector2(1,0), Vector2(-1, 0), Vector2(0,1), Vector2(0,-1)]

var catches = []
onready var player = $player
func _ready():
	spawn_catch()
func _process(delta):

	var input = get_input()
	
	player.position = player.position.linear_interpolate(input * 32, delta * 15)
	get_catch(input)
	

func get_input():
	var input_vert = -int(Input.is_action_pressed("UP")) + int(Input.is_action_pressed("DOWN"))
	var input_horz = -int(Input.is_action_pressed("LEFT")) + int(Input.is_action_pressed("RIGHT"))
	
		
	if abs(input_vert) && abs(input_horz) > 0:
		input_horz = 0
		

	
			
	return  Vector2(input_horz, input_vert)

func spawn_catch():
	for i in input_pos:
		var catch = load("res://entities/catch/catch.tscn").instance()
		$hit_boxes.add_child(catch)
		catch.input = i
		catch.position = i*32
		catches.append(catch)
		if i.x != 0:
			catch.rotation_degrees = 90
		
	

func get_catch(input):
	for catch in catches:
		if catch.input == input:
			if !catch.active:
				catch.active = true
				catch.just_pressed = true
				catch.time = 0
		else:
			catch.active = false
			catch.just_pressed = false
			
