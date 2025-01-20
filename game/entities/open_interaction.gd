class_name OpenInteraction

extends Interaction

@export var target: Trigger


func interact(interactor: Node) -> Result:
	var result: Result = Result.new()
	
	if not conditions_satisified():
		return result

	if not interactor.can_do(RobotCharacter.Abilities.DOORS):
		return result

	target.activate()
	return result
