extends Node
signal get_string(stng)
class_name MatrixText
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var decoders = ["$", ")", "(", "#", "-", "9", "1", "/", "&"]
var text = ""
var chars_decoded = 0
var decoded = []
var decision_time = 0.0
var decision_update = 0.04
var time = 1.0
var chars = 0.0
var count = 0
var update_tick = 0.02
var lbl = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _init(string:String, label:Label):
	text= string
	lbl = label
	lbl.add_child(self)
	chars = text.length() + 6
	print(chars)
	for c in chars:
		decoded.append(false)

func _process(delta: float) -> void:
	time += delta
	decision_time += delta
	count = 0
	var string = ""
	if time > update_tick:
		time = 0
		var true_check = true
		for c in text:
			count += 1
			if !decoded[count]:
				string += decoders[randi()%decoders.size()]
				true_check = false
			else:
				string += c
		if true_check:
			set_process(false)
			queue_free()
		lbl.text = string
	if decision_time > decision_update:
		decision_time = 0.0
		
		var decision_made = false
		while !decision_made:
			var rand_index = randi()%text.length() + 1
			if decoded[rand_index] == false:
				decision_made = true
				decoded[rand_index] = true
		
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
