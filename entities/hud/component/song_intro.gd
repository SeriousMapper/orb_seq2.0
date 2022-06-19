extends Control

onready var song_title = get_node("MarginContainer/PanelContainer/VBoxContainer/song_title")
onready var song_artist = get_node("MarginContainer/PanelContainer/VBoxContainer/song_artist")
onready var song_bpm = get_node("MarginContainer/PanelContainer/VBoxContainer/bpm")
func _ready() -> void:
	modulate.a = 0.0

func play_text(title, artist, bpm):

	
	$Tween.interpolate_property(self, "rect_position:y",50, 0, 0.8,Tween.TRANS_CUBIC)
	$Tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 0.8,Tween.TRANS_CUBIC)
	$Tween.start()
	yield(get_tree().create_timer(0.6),"timeout")
	var mt = MatrixText.new(title, song_title) 
	mt = MatrixText.new(artist, song_artist)
	mt = MatrixText.new(bpm, song_bpm)
	yield(get_tree().create_timer(3.0),"timeout")
	$Tween.interpolate_property(self, "rect_position:y", 0, -50, 0.8,Tween.TRANS_CUBIC)
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.8,Tween.TRANS_CUBIC)
	$Tween.start()
