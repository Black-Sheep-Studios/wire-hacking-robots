class_name HackInteraction

extends Interaction


@export var hack_scene: PackedScene
@export var fail_triggers: Array[Trigger]
@export var success_triggers: Array[Trigger]


func interact(interactor: Node) -> Result:
	var result = Result.new()

	if not conditions_satisified():
		return result

	if not interactor.can_do(RobotCharacter.Abilities.HACK):
		return result

	var hack: HackScene = hack_scene.instantiate()
	hack.hack_succeeded.connect(_on_success)
	hack.hack_failed.connect(_on_failure)
	
	result.hack = hack
	return result


func _on_success() -> void:
	for trigger in success_triggers:
		trigger.activate()


func _on_failure() -> void:
	for trigger in fail_triggers:
		trigger.activate()
