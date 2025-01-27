class_name OpenInteraction

extends Interaction

@export var target: Trigger


func interact(interactor: RobotCharacter) -> void:
	if not can_interact(interactor): return
	if not conditions_satisified(): return

	target.activate()


func _interact_label() -> String:
	return "Open"


func can_interact(interactor: RobotCharacter) -> bool:
	return interactor.can_do(RobotCharacter.Abilities.DOORS)
