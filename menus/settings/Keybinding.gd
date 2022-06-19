extends Control

signal mapped()
enum KEYS {UP, LEFT, RIGHT, DOWN}
var btns = {}
var btn_strings = []
var mapping = false
var current_map = ""
onready var key_cont = $PanelContainer/VBoxContainer
func _ready() -> void:
	create_keybinding()
	$PanelContainer/VBoxContainer/back.grab_focus()

func create_keybinding():
	for j in KEYS:
		var HBox = HBoxContainer.new()
		HBox.size_flags_horizontal = SIZE_FILL
		HBox.size_flags_vertical = SIZE_FILL
		HBox.alignment = BoxContainer.ALIGN_CENTER
		key_cont.add_child(HBox)
		var btn = Button.new()
		var key = Label.new()
		key.text = j
		btns[j] = btn
		btn.text = InputMap.get_action_list(j)[0].as_text()
		btn.connect("pressed", self, "input_pressed", [j, btn])
		HBox.add_child(key)
		HBox.add_child(btn)
func input_pressed(map, btn ):
	btn.text = "Bind"
	btn.release_focus()
	current_map = map
	mapping = true
	yield(self,"mapped")
	btn.text = InputMap.get_action_list(map)[0].as_text()
	btn.grab_focus()
func _input(event: InputEvent) -> void:
	if event.is_pressed() and mapping:
		if InputMap.get_action_list(current_map).size() > 0:
			InputMap.action_erase_event(current_map, InputMap.get_action_list(current_map)[0])
		for i in KEYS:
			if InputMap.action_has_event(i, event):
				InputMap.action_erase_event(i, event)
		InputMap.action_add_event(current_map, event)
		mapping = false
		current_map = ""
		reload_btns()
		emit_signal("mapped")
func reload_btns():
	for i in btns.keys():
		btns[i].text = "No key!"
		if InputMap.get_action_list(i).size() > 0:
			btns[i].text = InputMap.get_action_list(i)[0].as_text()


func _on_back_pressed() -> void:
	SceneChanger.change_scene("res://scenes/Settings.tscn")
