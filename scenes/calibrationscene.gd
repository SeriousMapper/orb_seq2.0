extends Node2D

var current_track = {"artist":"9th Hour", 
"bpm":120, 
"json":{6:"res://tracks/calibration_diddy.json"}, 
"mp3_path":"res://tracks/calibration_diddy.wav", 
"track_name":"Calibration"}
var current_difficulty = 6

func _ready() -> void:
	Player.current_song = current_track
	Player.current_difficulty = current_difficulty 
	$controller/track.connect('song_done', self, 'song_finished')
	
func song_finished() -> void:
	SceneChanger.change_scene('res://scenes/MainMenu.tscn')


