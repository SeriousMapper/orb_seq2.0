extends TextureRect


# Declare member variables here. Examples:

func _ready() -> void:
	pass


func play():
	$sfx.play()
	if !$animation.is_playing():
		$animation.play("blink")
