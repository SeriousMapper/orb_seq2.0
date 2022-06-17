extends ColorRect


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var minimum = 0.0
var maximum = 1.2
var acc = [0.8,0.9,0.2,0.6,0.5, 0.9]
var offset = Vector2.ZERO
var off = Vector2(32,32)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	acc = Player.note_accuracy
	offset = rect_size - off

func get_points():
	var points = []
	points.append(Vector2(0, rect_size.y))
	
	for i in acc.size():
		var point = Vector2.ZERO
		point.x = (float(i+1)/acc.size()) * offset.x
		point.y = acc[i] * -offset.y + offset.y
		points.append(point)
	points.append(rect_size)
	return points
func _draw() -> void:
	print(get_points())
	var count = 0
	var last_point
	for i in get_points():
		if count > 0:
			draw_line(last_point, i, Color(1,1,1,1.0), 2.0)
		count += 1
		last_point = i
		print(i)
