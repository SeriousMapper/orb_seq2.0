extends PanelContainer


onready var score = get_node("vbox/score_card/HBoxContainer/score/score_table/value/score")
onready var accuracy = get_node("vbox/score_card/HBoxContainer/score/score_table/value/accuracy")
onready var max_combo = get_node("vbox/score_card/HBoxContainer/score/score_table/value/max_combo")

onready var perfect = get_node("vbox/score_card/HBoxContainer/acc/acc_table/value/perfect")
onready var good = get_node("vbox/score_card/HBoxContainer/acc/acc_table/value/good")
onready var okay = get_node("vbox/score_card/HBoxContainer/acc/acc_table/value/okay")
func _ready() -> void:
	print(Player.score)
	score.text = "%010d" % Player.score
	print(score.text)
	max_combo.text = "%03d" % Player.max_combo
	perfect.text = "%03d" % Player.perfect
	good.text = "%03d" % Player.good
	okay.text = "%03d" % Player.okay
	accuracy.text = "%2.2f" % float(Player._calculate_accuracy() * 100.0) + "%"
