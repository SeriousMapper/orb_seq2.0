extends Control

var buttons = ["Quick_Play", "Calibration"]
var button_info = [
	"Play a favorite song, or pursue the leaderboards!",
	"From rags to riches, propel yourself to the best amongst the top 100 DJs.",
	"Look at your stats, such as gameplay time or accuracy.",
	"Adjust the settings to your desired needs.",
	"Calibrate your system to reduce latency when playing songs.",
	"View the leaderboards throughout the world and see where you belong!"
]
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var menu_title = get_node("Circle/info/VBoxContainer/menu_title")
onready var menu_info = get_node("Circle/info/VBoxContainer/menu_info")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RadialMenu.buttons = buttons
	$RadialMenu.connect("button_selected", self, "button_selected")
	$RadialMenu.connect("button_pressed", self, "button_pressed")
	SFX.fade_in_music()

func button_selected(btn):
	var index = buttons.find(btn)
	menu_title.text = btn
	menu_info.text = button_info[index]
func button_pressed(btn):
	match btn:
		"Quick_Play":
			SceneChanger.change_scene("res://menus/quick_play/quick_play.tscn")
		"Calibration":
			SceneChanger.change_scene("res://scenes/calibrationscene.tscn")
