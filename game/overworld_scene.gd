class_name OverworldScene

extends Scene

@onready var _player_robot_controller: PlayerRobotController = Util.require_child(self, PlayerRobotController)


func get_active_controller() -> PlayerController:
	return _player_robot_controller


func on_pause() -> void:
	_player_robot_controller.on_pause()


func on_resume() -> void:
	_player_robot_controller.on_resume()
