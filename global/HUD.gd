extends CanvasLayer

const floaty_text = preload("res://entities/hud/FloatyText.tscn")

func _ready():
	pass 

func spawn_floaty_text(position, text):
	var _floaty = floaty_text.instance()
	_floaty.global_position = position
	_floaty.text = text
	$hud_display.add_child(_floaty)
	
