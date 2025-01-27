class_name Hack
extends Interactable


@export var hack_scene: PackedScene
@export var fail_triggers: Array[Trigger]
@export var success_triggers: Array[Trigger]
@export var one_time: bool = false
@export var retry_on_failure: bool = true


func hack(player_controller: PlayerRobotController) -> Result:
	var result = Result.new()

	if not conditions_satisified():
		return result

	if not can_interact(player_controller.current_robot):
		return result

	var hack_scene_instance: HackScene = hack_scene.instantiate()
	hack_scene_instance.hack_succeeded.connect(func() -> void:
		_on_success(player_controller)
		if one_time:
			disable()
	)
	hack_scene_instance.hack_failed.connect(func() -> void:
		_on_failure(player_controller)
		if one_time or not retry_on_failure:
			disable()
	)
	
	result.hack_scene = hack_scene_instance
	return result


func _on_success(player_controller: PlayerRobotController) -> void:
	for trigger in success_triggers:
		trigger.activate(player_controller)


func _on_failure(player_controller: PlayerRobotController) -> void:
	for trigger in fail_triggers:
		trigger.activate(player_controller)


func can_interact(_interactor: RobotCharacter) -> bool:
	return _interactor.can_do(RobotCharacter.Abilities.HACK)


func _interact_label() -> String:
	return "Hack"


func _interact_input() -> InputPrompt.Type:
	return InputPrompt.Type.TERTIARY


class Result:
	var hack_scene: HackScene
