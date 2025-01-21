class_name Interaction

extends Node


func interact(_interactor: RobotCharacter) -> void:
	push_error(name, " does not override interact!")


func conditions_satisified() -> bool:
	var conditions: Array[Condition]
	for child in get_children():
		if child is Condition:
			conditions.append(child)
	
	for condition in conditions:
		if not condition.check():
			return false
	
	return true
