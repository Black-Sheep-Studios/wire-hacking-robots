class_name OpenInteraction

extends Interaction

@export var target: Trigger


func interact(interactor: Node) -> Result:
	var result: Result = Result.new()
	
	if not conditions_satisified():
		print("Conditions not satisfied")
		return result

	if not interactor.can_do(RobotCharacter.Abilities.DOORS):
		print("Interactor can't open doors")
		return result

	target.activate()

	result.success = true
	return result
