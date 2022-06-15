extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var matrix = MatrixText.new("00000000")
	matrix.connect("get_string", self, "update_text")
	add_child(matrix)

func update_text(string):
	text = string
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
