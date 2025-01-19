class_name OverworldScene

extends Scene

var _player_robot_controller: PlayerRobotController


func _ready() -> void:
	_player_robot_controller = Util.require_child(self, PlayerRobotController)


func get_active_controller() -> PlayerController:
	return _player_robot_controller
