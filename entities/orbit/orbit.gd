extends Sprite

export var orbit_r = 60
export var time = 0
export var speed = 5
var x_alteration = 1
var y_alteration = 1
var bh_factor_x = 0
var bh_factor_y = 0

func _ready():
	pass 

func _process(delta):
	
	if (Globals.blackholes.size() > 0):
		blackhole_pull()
	
	time += delta
	#orbit_r -= delta * 20
	position.x = (cos(time * speed) * orbit_r) + x_alteration
	position.y = (sin(time * speed) * orbit_r) + y_alteration
	
 
func blackhole_pull():
	for bh in Globals.blackholes:
		if (dist_calc(bh.pos_x, bh.pos_y, bh.grav_radius)):
			bh_factor_x = (bh.pos_x - position.x) * bh.gravity
			bh_factor_y = (bh.pos_y - position.y) * bh.gravity
			x_alteration += bh_factor_x
			y_alteration += bh_factor_y
			bh_factor_x = 0
			bh_factor_y = 0
			
func dist_calc(x, y, rad):
	if (sqrt(pow(x, 2) + pow(y, 2)) < 80):
		return true
	else:
		return false	
