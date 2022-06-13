extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spectrum
onready var tween = $Tween
var direction = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.modulate = Color("#ffffff")
	
	

func _process(delta):
	pass

func _on_track_quarter_note():
	if (direction):
		tween.interpolate_property($Sprite, "scale", Vector2(6, 6), Vector2(8, 8), 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		direction = !direction
		print("hello")
	else:
		tween.interpolate_property($Sprite, "scale", Vector2(8, 8), Vector2(6, 6), 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		direction = !direction
