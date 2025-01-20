class_name HackScene

extends Scene

signal hack_succeeded
signal hack_failed
signal hack_cancelled

var _player_hack_controller: PlayerHackController

func _init() -> void:
	# minigames should still animate and process normally when the game is paused
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS


func _ready() -> void:
	_player_hack_controller = Util.require_child(self, PlayerHackController)


func _on_fail() -> void:
	hack_failed.emit()
	_scene_manager.pop_scene()


func _on_success() -> void:
	hack_succeeded.emit()
	_scene_manager.pop_scene()


func _on_cancel() -> void:
	hack_cancelled.emit()
	_scene_manager.pop_scene()


func get_active_controller() -> PlayerController:
	return _player_hack_controller
