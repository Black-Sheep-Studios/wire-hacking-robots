class_name OpenInteraction

extends Interaction

@export var target: Trigger


func interact(interactor: Node) -> void:
	if not conditions_satisified(): return
	if not interactor.can_do(RobotCharacter.Abilities.DOORS): return

	target.activate()
