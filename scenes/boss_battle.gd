extends Node2D
var current_track = {"artist":"9Hour", 
"bpm":107, 
"json":{6:"res://tracks/innit_boss.json"}, 
"mp3_path":"res://tracks/innit.mp3", 
"track_name":"Innit (Boss)"}
var current_diff = 6

var boss_health = 100
var boss_name = "Sq_002_45"
func _ready() -> void:
	$controller/track.connect("note_hit", self, "note_hit")
	$controller/track.connect("boss_note_warning",self, "boss_warning")
	$controller/track.connect("boss_note_pos", self, "update_boss_pos")
	update_boss_ui()
func note_hit(note):
	if note.boss_note and note.hit:
		SFX.play_sound_ui(SFX.button_select)
		boss_health -= Player.damage
		update_boss_ui()
		$boss.get_hit()
		$boss.emit_hit()
		if boss_health < 0:
			print("Boss defeated")
func update_boss_ui():
	var boss_ui = $Boss_UI/ui
	var prog_bar = boss_ui.get_node("MarginContainer/VBoxContainer/ProgressBar")
	var boss_text = boss_ui.get_node("MarginContainer/VBoxContainer/Label")
	boss_text.text = boss_name
	prog_bar.value = boss_health
func update_boss_pos(pos):
	$boss.set_pos(pos)
func boss_warning(pos):
	$Boss_UI/arrows.play_boss_alert(pos)


func _on_track_song_done() -> void:
	HUD.hide_combo_box()
	if boss_health < 0.0:
		SceneChanger.change_scene("res://menus/debriefing/debriefing.tscn")
	else:
		Player.health = -0.01
		$controller/track.game_over()
		boss_health = 100
	print("song is finished")
