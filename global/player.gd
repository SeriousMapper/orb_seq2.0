extends Node
const MAX_COMBO_MULT = 4.0
var combo = 0
var max_combo = 0.0
var combo_multiplier = 1.0
var perfect = 0
var good = 0
var okay = 0
var score = 0
var note_accuracy = []
var note_time_accuracy = []

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
		
