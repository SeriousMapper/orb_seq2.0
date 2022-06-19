extends Button

var track_init = ""
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func reload(track):
	if Globals.tracks.has(track):
			
		track = Globals.tracks[track]
		$MarginContainer/hbox/cover.texture = load(track.cover)
		$MarginContainer/hbox/VBoxContainer/title.text = track.track_name
		$MarginContainer/hbox/VBoxContainer/artist.text= track.artist
		$MarginContainer/hbox/VBoxContainer/bpm.text = str(track.bpm) + " BPM"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
