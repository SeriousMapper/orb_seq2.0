extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var note_accs = []

onready var track = get_node('../track')


func _ready():
	track.connect('song_done', self, 'calc_avg_accuracy')
	
func calc_avg_accuracy():
	var avg = 0
	for acc in Player.note_time_accuracy:
		avg += acc
	avg = avg / Player.note_time_accuracy.size()
	print("avg accuracy from calibration script: " + str(avg))
	Globals.set_latency(-avg)
	#TODO ----- Save latency into a persistant file (?)
