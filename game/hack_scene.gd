class_name HackScene

extends Scene

signal hack_succeeded
signal hack_failed
signal hack_cancelled

@onready var _player_hack_controller: PlayerHackController = Util.require_child(self, PlayerHackController)


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
