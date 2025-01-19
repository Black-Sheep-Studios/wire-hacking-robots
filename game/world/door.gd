class_name Door

extends Interactable


@export var is_open: bool = false


func interact(interactor: Node2D) -> Result:
	var result: Result = Result.new()
	var can_open: bool = interactor.can_do(RobotCharacter.Abilities.DOORS)

	if can_open:
		is_open = not is_open
		result.success = true
	
	return result
