extends Control

onready var score = get_node("MarginContainer/Score")
onready var combo = get_node("MarginContainer2/VBoxContainer/combo")
onready var max_combo = get_node("MarginContainer2/VBoxContainer/max_combo")
onready var combo_multiplier = get_node("MarginContainer2/VBoxContainer/combo_mult")
onready var perfect = get_node("MarginContainer3/VBoxContainer/Perfect")
onready var good = get_node("MarginContainer3/VBoxContainer/Good")
onready var okay = get_node("MarginContainer3/VBoxContainer/Okay")

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	score.text = "_score: " + "%010d" % Player.score
	combo.text = "_combo: " + "%03d" % Player.combo
	combo_multiplier.text = "_mult: " + "%2.2f" % Player.combo_multiplier
	max_combo.text = "_max_combo: " + "%03d" % Player.max_combo
	perfect.text = "_perfect: " + "%03d" % Player.perfect
	good.text = "_good: " + "%03d" % Player.good
	okay.text = "_okay: " + "%03d" % Player.okay
