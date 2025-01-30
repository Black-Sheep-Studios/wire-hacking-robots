class_name Hack
extends Interactable


@export var hack_scene: PackedScene

@export var one_time: bool = false
@export var retry_on_failure: bool = true


func hack(player_controller: PlayerRobotController) -> InteractResult:
	var result = InteractResult.new()

	if not conditions_satisified():
		return result

	if not can_interact(player_controller.current_robot):
		return result

	var hack_scene_instance: HackScene = hack_scene.instantiate()
	hack_scene_instance.outcome_triggered.connect(func(index: Outcome.Index) -> void:
		_on_hack_outcome_triggered(player_controller, index)
	)

	var outcome_labels: Array[String] = []
	for outcome in _success_outcomes():
		outcome_labels.append(outcome.outcome_label)
	hack_scene_instance.initialize_outcomes(outcome_labels)
	
	result.hack_scene = hack_scene_instance
	return result


func _on_hack_outcome_triggered(player_controller: PlayerRobotController, index: Outcome.Index) -> void:
	var payload: Outcome.Payload = Outcome.Payload.new()
	payload.player_controller = player_controller
	payload.target = parent_object

	if index == Outcome.Index.Failure:
		for outcome in _failure_outcomes():
			outcome.trigger(payload)
	else:
		var success_outcomes: Array[Outcome] = _success_outcomes()
		if index >= success_outcomes.size():
			push_error(get_path(), " does not have an outcome for index ", str(index), " but it was triggered")
			return
		success_outcomes[index].trigger(payload)


func _all_outcomes() -> Array[Outcome]:
	var outcomes: Array[Outcome] = []
	for outcome in get_children():
		if outcome is Outcome:
			outcomes.append(outcome)
	
	return outcomes


func _success_outcomes() -> Array[Outcome]:
	var outcomes: Array[Outcome] = []
	for outcome in _all_outcomes():
		if not outcome.failure:
			outcomes.append(outcome)
	
	return outcomes


func _failure_outcomes() -> Array[Outcome]:
	var outcomes: Array[Outcome] = []
	for outcome in _all_outcomes():
		if outcome.failure:
			outcomes.append(outcome)
	
	return outcomes


func can_interact(_interactor: RobotCharacter) -> bool:
	return _interactor.can_do(RobotCharacter.Abilities.HACK)


func _interact_label() -> String:
	return "Hack"


func _interact_input() -> InputPrompt.Type:
	return InputPrompt.Type.TERTIARY


class InteractResult:
	var hack_scene: HackScene
