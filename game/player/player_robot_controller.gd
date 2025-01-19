class_name PlayerRobotController

extends PlayerController


@export var current_robot: Node2D


func process(delta: float) -> void:
	if !current_robot: return

	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if move_direction != Vector2.ZERO: 
		current_robot.move(delta, move_direction)
