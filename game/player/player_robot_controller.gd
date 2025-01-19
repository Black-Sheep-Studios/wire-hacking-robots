class_name PlayerRobotController

extends PlayerController


@export var current_robot: RobotCharacter

var _scene_manager: SceneManager


func init(scene_manager: SceneManager) -> void:
	_scene_manager = scene_manager


func process(delta: float) -> void:
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
	
	return action


func _process_action_result(action_result: RobotCharacter.ActionResult) -> void:
	# TODO: maybe a failure sound effect, UI toast, etc
	if !action_result.interact_result.success: return

	var interact_result: Interactable.Result = action_result.interact_result

	if [Interactable.Result.Type.CODEHACK, Interactable.Result.Type.WIREHACK].has(interact_result.type):
		_scene_manager.set_active_scene(interact_result.minigame, true)


func _get_interact_target() -> Interactable:
	# TODO: this is just grabbing the closes interactable object, but this will probably make
	# more sense later to reimplement with the mouse direction and a raycast to get whatever
	# the player is aiming at
	var interactables: Array[Interactable] = current_robot.interaction_reach_area.get_interactables()
	if interactables.size() == 0: return null

	interactables.sort_custom(func(a: Interactable, b: Interactable) -> bool:
		return a.global_position.distance_to(current_robot.global_position) < b.global_position.distance_to(current_robot.global_position)
	)
	return interactables[0]
