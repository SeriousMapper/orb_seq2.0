extends Sprite

export var pos_x = 0
export var pos_y = 0
export var time = -10
export var speed = 8
export var total_time = 10
export var end_x = 0
export var end_y = 0
export var gravity = 0
var counter = 0
var still_flag = false
var start_pos_x = 0
var start_pos_y = 0
var rng = RandomNumberGenerator.new()
var grav_radius = 0

signal blackhole_spawned


func _ready():
	Globals.blackholes.append(self)
	rng.randomize()
	start_pos_x = rng.randf_range(-320, 320)
	start_pos_y = rng.randf_range(-180, 180)
	grav_radius = rng.randf_range(0, 200)
	gravity = rng.randf_range(0.0001, 0.0009)
	

func _process(delta):
	time += delta
	if (!still_flag):
		position.x = (start_pos_x * (1 - (time / total_time)))
		position.y = (start_pos_y * (1 - (time / total_time))) 
		pos_x = position.x
		pos_y = position.y
	if (total_time - time < 0):
		still_flag = true
	counter += 1
	
func check_despawn():
	if (total_time - time < 0):
		queue_free()
		var index = Globals.blackholes.find(self)
		Globals.blackholes.remove(index)
