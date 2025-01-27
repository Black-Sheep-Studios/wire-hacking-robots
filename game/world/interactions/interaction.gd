class_name Interaction
extends Interactable


func interact(_interactor: RobotCharacter) -> void:
	push_error("Interaction ", get_path(), " does not override interact!")


func _interact_label() -> String:
	push_warning("Interaction ", get_path(), " does not override _interact_label!")
	return "Interact"


func _interact_input() -> InputPrompt.Type:
	return InputPrompt.Type.SECONDARY
