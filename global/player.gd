extends Node
const MAX_COMBO_MULT = 4.0
var combo = 0
var max_combo = 0
var combo_multiplier = 1.0
var perfect = 0
var good = 0
var okay = 0
var score = 250
var note_accuracy = []
var note_time_accuracy = []
var current_song = {"artist":"9Hour", 
"bpm":107, 
"json":{6:"res://track_folder/arrithmia/track3.json"}, 
"mp3_path":"res://track_folder/arrithmia/track3.mp3", 
"track_name":"Arrithmia"}
var current_difficulty = 6
func clear():
	note_accuracy = []
	note_time_accuracy = []
	score = 0
	okay = 0
	good = 0
	perfect = 0
	combo_multiplier = 1.0
	max_combo = 0
	combo = 0
func _ready() -> void:
	pass

func add_combo():
	combo += 1
	combo_multiplier += 0.05
	if combo_multiplier > MAX_COMBO_MULT:
		combo_multiplier = MAX_COMBO_MULT
	score += 5 * combo_multiplier
func remove_combo():
	combo = 0
	combo_multiplier = 1.0
func _calculate_accuracy():
	var sum = 0
	var avg = 0.0
	
	if note_accuracy.size() > 0:
		for i in note_accuracy:
			sum += i
		avg = sum/note_accuracy.size()
	return avg
		
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
