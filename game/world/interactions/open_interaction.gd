class_name OpenInteraction

extends Interaction

@export var target: Trigger


func _init() -> void:
	if interaction_label == "":
		interaction_label = "Open"


func interact(interactor: RobotCharacter) -> void:
	if not interactor.can_do(RobotCharacter.Abilities.DOORS): return
	if not conditions_satisified(): return

	target.activate()
