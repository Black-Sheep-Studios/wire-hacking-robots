class_name PlayerRobotController

extends PlayerController


@export var _pause_menu_scene: PackedScene
@export var current_robot: RobotCharacter


func process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		var pause_scene: Scene = _pause_menu_scene.instantiate()
		_scene_manager.set_active_scene(pause_scene, true)
		return

	if !current_robot: return

	var action: RobotCharacter.Action = _build_action_from_inputs()
	action.delta = delta

	var action_result: RobotCharacter.ActionResult = current_robot.act(action)

	_process_action_result(action_result)


func _build_action_from_inputs() -> RobotCharacter.Action:
	var action: RobotCharacter.Action = RobotCharacter.Action.new()
	action.movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if Input.is_action_just_pressed("primary_action"):
		action.interact_target = _get_interact_target()

	var mouse_position: Vector2 = get_viewport().get_mouse_position() - get_viewport().canvas_transform.origin
	action.aim_direction = (mouse_position - current_robot.global_position).normalized()
	
	return action


func _process_action_result(action_result: RobotCharacter.ActionResult) -> void:
	if action_result.interact_result:
		_process_interact_result(action_result.interact_result)


func _process_interact_result(interact_result: Interaction.Result) -> void:
	if interact_result.hack:
		_scene_manager.set_active_scene(interact_result.hack)


func _get_interact_target() -> Interaction:
	var current_aimed_object: Object = current_robot.aim_raycast.get_collider()
	if !current_aimed_object: return null

	var interaction: Interaction = Util.find_child(current_aimed_object, Interaction)
	if interaction:
		return interaction

	return null
