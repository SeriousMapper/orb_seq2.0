extends Control



func _ready() -> void:
	pass 
func play_boss_alert(pos):
	if pos.x == 1:
		$right_arrow.play()
	if pos.y == 1:
		$down_arrow.play()
	if pos.y == -1:
		$up_arrow.play()
	if pos.x == -1:
		$left_arrow.play()
