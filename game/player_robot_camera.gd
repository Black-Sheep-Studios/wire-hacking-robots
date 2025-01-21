class_name PlayerRobotCamera

extends Camera2D


@export var player_robot_controller: PlayerRobotController
@export var tracking_strength: float = 0.2


func _ready() -> void:
	if not player_robot_controller:
		push_error("PlayerRobotCamera needs a PlayerRobotController to track")
		return

	if _player_robot():
		position = _player_robot().global_position


func _process(_delta: float) -> void:
	if not _player_robot():
		return

	position = _player_robot().global_position.lerp(position, tracking_strength)


func _player_robot() -> RobotCharacter:
	return player_robot_controller.current_robot
