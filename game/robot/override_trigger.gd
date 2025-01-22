class_name OverrideTrigger

extends Trigger

@onready var robot: RobotCharacter = get_parent()


func activate(interactor: Node = null) -> void:
	if (not interactor) or (interactor is not PlayerRobotController): return
	var player_controller = interactor as PlayerRobotController

	player_controller.control_robot(robot)
