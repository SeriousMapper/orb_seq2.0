extends Node

signal settings_loaded

var save_path = 'res://settings.cfg'
var config = ConfigFile.new()
var load_response = config.load(save_path)
var game_settings = ["latency"]
const DEFAULT_LATENCY = 0


func _ready():
	emit_signal('settings_loaded')
	
func save_latency(value):
	print("SETTING LATENCY " + str(value))
	config.set_value('game_settings', 'latency', value)
	config.save(save_path)

func load_latency(section, key) -> float:
	print("LOADING LATENCY " + str(config.get_value('game_settings', 'latency', DEFAULT_LATENCY)))
	return config.get_value('game_settings', 'latency', DEFAULT_LATENCY)
