class_name PlayerRobotController

extends PlayerController


@export var _pause_menu_scene: PackedScene
@export var current_robot: RobotCharacter


func process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		_scene_manager.set_active_scene(_pause_menu_scene, true)

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

	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	action.aim_direction = (mouse_position - current_robot.global_position).normalized()
	
	return action


func _process_action_result(action_result: RobotCharacter.ActionResult) -> void:
	if action_result.interact_result:
		_process_interact_result(action_result.interact_result)


func _process_interact_result(interact_result: Interactable.Result) -> void:
	if !interact_result.success: return

	if [Interactable.Result.Type.CODEHACK, Interactable.Result.Type.WIREHACK].has(interact_result.type):
		_scene_manager.set_active_scene(interact_result.minigame, true)


func _get_interact_target() -> Interactable:
	var current_aimed_object: Object = current_robot.aim_raycast.get_collider()
	if current_aimed_object is Interactable:
		return current_aimed_object
	return null
