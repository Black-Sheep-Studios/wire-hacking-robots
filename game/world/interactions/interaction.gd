class_name Interaction

extends Node


func interact(_interactor: RobotCharacter) -> void:
	push_error(name, " does not override interact!")


func conditions_satisified() -> bool:
	for child in get_children():
		if child is Condition:
			if not child.is_satisfied:
				return false
	
	return true
