extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Button.connect("pressed", self, "_continue")
	$Button.grab_focus()

func _continue():
	Player.clear()
	SceneChanger.change_scene("res://menus/quick_play/quick_play.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

