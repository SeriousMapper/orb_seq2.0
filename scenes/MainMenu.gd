extends Control

var buttons = ["Quick_Play", "Settings", "Calibration"]
var button_info = [
	"Play a favorite song, or pursue the leaderboards!",
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
	$notifier.text = ""
	$RadialMenu.buttons = buttons
	$RadialMenu.connect("button_selected", self, "button_selected")
	$RadialMenu.connect("button_pressed", self, "button_pressed")
	$RadialMenu._rotate_buttons(-1)
	SFX.fade_in_music()
	HUD.hide_display()

func button_selected(btn):
	var index = buttons.find(btn)
	menu_title.text = btn
	menu_info.text = button_info[index]
func button_pressed(btn):
	match btn:
		"Quick_Play":
			SceneChanger.change_scene("res://menus/quick_play/quick_play.tscn")
		"Save_Game":
			Player.save_player_data()
			$notifier.text = "Save Success!"
			yield(get_tree().create_timer(1.0),"timeout")
			$notifier.text = ""
			$RadialMenu.set_process(true)
		"Load_Game":
			Player.load_player_data()
			$notifier.text = "Load Success!"
			yield(get_tree().create_timer(1.0),"timeout")
			$notifier.text = ""
			$RadialMenu.set_process(true)
		"Settings":
			SceneChanger.change_scene("res://scenes/Settings.tscn")
