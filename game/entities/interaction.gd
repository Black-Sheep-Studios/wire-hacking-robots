class_name Interaction

extends Node


func interact(_interactor: Node) -> Result:
	push_error("Interaction.interact() called; must be overridden in derived class")
	return null


func conditions_satisified() -> bool:
	var conditions: Array[Condition]
	for child in get_children():
		if child is Condition:
			conditions.append(child)
	
	for condition in conditions:
		if not condition.check():
			return false
	
	return true


class Result:
	enum Type {
		HACK
	}

	var type: Type
	var hack: HackScene
