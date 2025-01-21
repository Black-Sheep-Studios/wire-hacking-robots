class_name PlayerRobotController

extends PlayerController


@export var _pause_menu_scene: PackedScene
@export var current_robot: RobotCharacter

const attack_key: String = "primary_action"
const interact_key: String = "secondary_action"
const hack_key: String = "tertiary_action"

func process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		var pause_scene: Scene = _pause_menu_scene.instantiate()
		_scene_manager.set_active_scene(pause_scene, true)
		return

	if !current_robot: return

	var aim_target: Node2D = _get_aim_target()
	if aim_target: _process_aim_target_inputs(aim_target, delta)

	var action: RobotCharacter.Action = _build_action_from_inputs()
	action.delta = delta

	current_robot.act(action)


func control_robot(robot: RobotCharacter) -> void:
	current_robot = robot


func _build_action_from_inputs() -> RobotCharacter.Action:
	var action: RobotCharacter.Action = RobotCharacter.Action.new()
	action.movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if Input.is_action_just_pressed(attack_key):
		action.attack = true

	action.aim_direction = (current_robot.get_global_mouse_position() - current_robot.global_position).normalized()
	
	return action


func _process_aim_target_inputs(aim_target: Node2D, _delta: float) -> void:
	if Input.is_action_just_pressed(interact_key):
		var interaction_target: Interaction = Util.find_child(aim_target, Interaction)
		if interaction_target: _process_interaction(interaction_target)
	elif Input.is_action_just_pressed(hack_key):
		var hack_target: Hack = Util.find_child(aim_target, Hack)
		if hack_target: _process_hack(hack_target)


func _process_interaction(interaction_target: Interaction) -> void:
	interaction_target.interact(current_robot)


func _process_hack(hack_target: Hack) -> void:
	var result: Hack.Result = hack_target.hack(current_robot)
	if result.hack_scene:
		_scene_manager.set_active_scene(result.hack_scene, true)


func _get_aim_target() -> Node2D:
	return current_robot.aim_raycast.get_collider()

