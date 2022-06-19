extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/VBoxContainer/master.grab_focus()
	$PanelContainer/VBoxContainer/master.value = AudioServer.get_bus_volume_db(0)
	$PanelContainer/VBoxContainer/song.value = AudioServer.get_bus_volume_db(2)
	$PanelContainer/VBoxContainer/menu.value = AudioServer.get_bus_volume_db(3)
func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)


func _on_song_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)


func _on_menu_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(3, value)


func _on_Button_pressed() -> void:
	SceneChanger.change_scene("res://scenes/Settings.tscn")
