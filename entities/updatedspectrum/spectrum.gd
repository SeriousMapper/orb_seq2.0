extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spectrum
onready var tween = $Tween
onready var tween2 = $Tween2
var direction = true
var quarter_speed = 0.6
var eighth_speed = 0.4
var sixt_speed = 0.2
var spec_id
var track
var time = 0
var secs_per_beat

# Called when the node enters the scene tree for the first time.
func _ready():
	spec_id = Globals.spec_num
	Globals.spec_num += 1
	spec_id = spec_id % 3
	track = get_node('../track')
	track.connect("quarter_note", self, "_on_track_quarter_note")
	secs_per_beat = 10
	
func _process(delta):
	time += delta
	if (track.secs_per_beat != 0):
		secs_per_beat = track.secs_per_beat 
	var radius = (sin((time/secs_per_beat) * (PI/2)) * 15) + 15
	$Sprite.material.set_shader_param('radius', radius)
	
	
func _on_track_quarter_note():
	#expand_circle((quarter_speed / spec_id) + 0.1)
	if (spec_id == 0):
		expand_circle(quarter_speed)
	elif (spec_id == 1):
		expand_circle(eighth_speed)
	elif(spec_id == 2):
		expand_circle(sixt_speed)

func expand_circle(speed):
	tween.interpolate_property($Sprite, "scale", Vector2(0.15, 0.15), Vector2(0.2, 0.2), speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property($Sprite, "scale", Vector2(0.2, 0.2), Vector2(0.15, 0.15), speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	#if (direction):
	#	tween.interpolate_property($Sprite, "scale", Vector2(0.15, 0.15), Vector2(0.2, 0.2), speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#	tween.start()
	#	direction = !direction
	#else:
	#	tween.interpolate_property($Sprite, "scale", Vector2(0.2, 0.2), Vector2(0.15, 0.15), speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#	tween.start()
	#	direction = !direction

