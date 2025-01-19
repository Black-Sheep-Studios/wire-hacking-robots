class_name PlayerRobotController

extends PlayerController


@export var current_robot: RobotCharacter


func process(_delta: float) -> void:
	if !current_robot: return

	var action: RobotCharacter.Action = RobotCharacter.Action.new()
	action.movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if Input.is_action_just_pressed("primary_action"):
		action.interact_target = get_interact_target()

	current_robot.act(action)


func get_interact_target() -> Node2D:
	return null
