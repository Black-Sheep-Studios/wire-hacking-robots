class_name Hack

extends Interactable


@export var hack_scene: PackedScene


func interact(interactor: Node2D) -> Result:
	var result: Result = Result.new()
	var can_hack: bool = interactor.can_do(RobotCharacter.Abilities.HACK)

	if can_hack:
		result.type = Result.Type.WIREHACK
		result.success = true
		result.minigame = hack_scene

	return result
