class_name Hack

extends Node


@export var hack_scene: PackedScene
@export var fail_triggers: Array[Trigger]
@export var success_triggers: Array[Trigger]


func hack(player_controller: PlayerRobotController) -> Result:
	var result = Result.new()

	if not player_controller.current_robot.can_do(RobotCharacter.Abilities.HACK):
		return result

	var hack_scene_instance: HackScene = hack_scene.instantiate()
	hack_scene_instance.hack_succeeded.connect(func() -> void:
		_on_success(player_controller)
	)
	hack_scene_instance.hack_failed.connect(_on_failure)
	
	result.hack_scene = hack_scene_instance
	return result


func _on_success(player_controller: PlayerRobotController) -> void:
	for trigger in success_triggers:
		trigger.activate(player_controller)


func _on_failure(player_controller: PlayerRobotController) -> void:
	for trigger in fail_triggers:
		trigger.activate(player_controller)


class Result:
	var hack_scene: HackScene
