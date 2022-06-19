extends Control


var submenus = ["Audio_Settings", "Key_Binding"]
var submenu_desc = ["Configure audio and volume.", "Rebind your directional keys."]
func _ready() -> void:
	$RadialMenu.buttons = submenus
	$RadialMenu.connect("button_pressed", self, "button_pressed")
	$RadialMenu.connect("button_selected", self, "button_selected")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		SceneChanger.change_scene("res://scenes/MainMenu.tscn")
func button_selected(btn):
	$Circle/menu_title.text = btn
	var index = submenus.find(btn)
	$Circle/menu_title/menu_info.text = submenu_desc[index]
func button_pressed(btn):
	match btn:
		"Audio_Settings":
			SceneChanger.change_scene("res://menus/settings/SoundSettings.tscn")
		"Key_Binding":
			SceneChanger.change_scene("res://menus/settings/Keybinding.tscn")
