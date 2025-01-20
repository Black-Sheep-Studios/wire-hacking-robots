class_name Door

extends Interactable


@export var is_open: bool = false


func interact(interactor: Node2D) -> Result:
	var result: Result = Result.new()
	var can_open: bool = interactor.can_do(RobotCharacter.Abilities.DOORS)

	if can_open:
		result.success = true
		if is_open:
			is_open = false
			print("Door closed!")
		else:
			is_open = true
			print("Door opened!")
	
	return result
