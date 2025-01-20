class_name HackScene

extends Scene

var _player_hack_controller: PlayerHackController

func _init() -> void:
	# minigames should still animate and process normally when the game is paused
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS


func _ready() -> void:
	_player_hack_controller = Util.require_child(self, PlayerHackController)


func get_active_controller() -> PlayerController:
	return _player_hack_controller
