extends Node
signal game_over()
signal saved()
signal combo_tick()
signal bad_tick()
const MAX_COMBO_MULT = 4.0
const COMBO_COUNT_TICK = 100
const BAD_TICK = 10
var combo = 0
var max_combo = 0
var combo_multiplier = 1.0
var combo_counter = 0
var bad_counter = 0
var perfect = 0
var good = 0
var okay = 0
var score = 0
var health = 1.0
var note_accuracy = []
var note_time_accuracy = []
var current_song = {"artist":"9Hour", 
"bpm":107, 
"json":{6:"res://track_folder/arrithmia/track3.json"}, 
"mp3_path":"res://track_folder/arrithmia/track3.mp3", 
"track_name":"Arrithmia",
"cover": "res://track_folder/heaven/cover.jpg"}
var hi_scores = {}
var current_difficulty = 6
var damage = 1
func clear():
	if !hi_scores.has(current_song.track_name):
		hi_scores[current_song.track_name] = {}
	hi_scores[current_song.track_name] = save_score_data()
	print(current_song)
	print(hi_scores[current_song.track_name])
	note_accuracy = []
	note_time_accuracy = []
	score = 0
	okay = 0
	good = 0
	perfect = 0
	health = 1.0
	combo_multiplier = 1.0
	max_combo = 0
	combo = 0
	save_player_data()
func wipe():
	note_accuracy = []
	note_time_accuracy = []
	score = 0
	okay = 0
	good = 0
	perfect = 0
	health = 1.0
	combo_multiplier = 1.0
	max_combo = 0
	combo = 0
func _ready() -> void:
	pass

func add_combo():
	combo += 1
	bad_counter = 0
	combo_counter += 1
	HUD.add_tick_to_combo()
	if combo_counter > COMBO_COUNT_TICK:
		combo_counter = 0
		emit_signal("combo_tick")
		HUD.show_combo_box()
		SFX.play_random(SFX.good_vox)
	combo_multiplier += 0.05
	
	if combo_multiplier > MAX_COMBO_MULT:
		combo_multiplier = MAX_COMBO_MULT
	if combo > max_combo:
		max_combo = combo
	score += 5 * combo_multiplier
func remove_combo():
	bad_counter += 1
	if HUD.combo_visible:
		HUD.hide_combo_box()
	if bad_counter > BAD_TICK:
		bad_counter = 0
		
		SFX.play_random(SFX.bad_vox)
		emit_signal("bad_tick")
	combo = 0
	combo_counter = 0
	combo_multiplier = 1.0
	Player.health -= 0.05
	if Player.health < 0:
		emit_signal("game_over")
func _calculate_accuracy():
	var sum = 0
	var avg = 0.0
	
	if note_accuracy.size() > 0:
		for i in note_accuracy:
			sum += i
		avg = sum/note_accuracy.size()
	return avg
func save_score_data():
	var score_save = {"letter_grade": get_track_quality()[0],
		"max_combo": max_combo, "score":score, "perfect": perfect,
	"okay":okay, "good":good, "accuracy":_calculate_accuracy()}
	return score_save
func save_player_data():
	Globals.save(Globals.player_file, hi_scores)
func load_player_data():
	var data = Globals.load_from_file(Globals.player_file)
	if data != null:
		hi_scores = data
func get_track_quality() -> Array:
	var acc = _calculate_accuracy()
	var letter_grade = ""
	var descrip = ""
	if acc >= 0.0:
		letter_grade = "F"
		descrip = "You fail."
	if acc > 0.6:
		letter_grade = "D"
		descrip = "Nuclear"
	if acc > 0.7:
		letter_grade = "C"
		descrip = "Alright"
	if acc > 0.8:
		letter_grade = "B"
		descrip = "You have potential."
	if acc > 0.9:
		letter_grade = 'A'
		descrip = "Amazing work!"
	if acc > 0.96:
		letter_grade = "S"
		descrip = "Extraterrestrial"
	return [letter_grade, descrip]
