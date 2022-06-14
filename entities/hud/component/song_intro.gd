extends Control

onready var song_title = get_node("MarginContainer/PanelContainer/VBoxContainer/song_title")
onready var song_artist = get_node("MarginContainer/PanelContainer/VBoxContainer/song_artist")
onready var song_bpm = get_node("MarginContainer/PanelContainer/VBoxContainer/bpm")
func _ready() -> void:
	pass

func play_text(title, artist, bpm):
	MatrixText.new(title, song_title) 
	MatrixText.new(artist, song_artist)
	MatrixText.new(bpm, song_bpm)
	$AnimationPlayer.seek(0.0)
	$AnimationPlayer.play("show")
	yield(get_tree().create_timer(4.0),"timeout")
	$AnimationPlayer.play("hide")
	
	
