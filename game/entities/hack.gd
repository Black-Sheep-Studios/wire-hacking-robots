class_name Hack

extends Node


@export var hack_scene: PackedScene
@export var fail_triggers: Array[Trigger]
@export var success_triggers: Array[Trigger]


func hack(interactor: RobotCharacter) -> Result:
	var result = Result.new()

	if not interactor.can_do(RobotCharacter.Abilities.HACK):
		return result

	var hack_scene_instance: HackScene = hack_scene.instantiate()
	hack_scene_instance.hack_succeeded.connect(_on_success)
	hack_scene_instance.hack_failed.connect(_on_failure)
	
	result.hack_scene = hack_scene_instance
	return result


func _on_success() -> void:
	for trigger in success_triggers:
		trigger.activate()


func _on_failure() -> void:
	for trigger in fail_triggers:
		trigger.activate()


class Result:
	var hack_scene: HackScene
