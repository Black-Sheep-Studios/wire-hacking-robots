class_name HackInteraction

extends Interaction


@export var hack_scene: PackedScene
@export var fail_triggers: Array[Trigger]
@export var success_triggers: Array[Trigger]


func interact(interactor: Node) -> Result:
	print("Interacting with hack interaction")
	var result = Result.new()

	if not conditions_satisified():
		print("Conditions not satisfied")
		return result

	if not interactor.can_do(RobotCharacter.Abilities.HACK):
		print("Interactor can't hack")
		return result

	print("Starting hack")
	var hack: HackScene = hack_scene.instantiate()
	hack.hack_succeeded.connect(_on_success)
	hack.hack_failed.connect(_on_failure)
	
	result.hack = hack
	result.success = true
	return result


func _on_success() -> void:
	for trigger in success_triggers:
		trigger.activate()


func _on_failure() -> void:
	for trigger in fail_triggers:
		trigger.activate()
