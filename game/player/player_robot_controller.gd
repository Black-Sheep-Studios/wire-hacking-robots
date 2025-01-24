class_name PlayerRobotController
extends PlayerController


@export var _pause_menu_scene: PackedScene
@export var current_robot: RobotCharacter

const attack_key: String = "primary_action"
const interact_key: String = "secondary_action"
const hack_key: String = "tertiary_action"

@onready var cursor: Cursor = Util.require_child(self, Cursor)

var _skip_frame: bool = false


func _ready() -> void:
	_replace_mouse_cursor()


func process(delta: float) -> void:
	if _skip_frame:
		_skip_frame = false
		return

	cursor.global_position = current_robot.get_global_mouse_position()
	_restore_cursor_outside_window()

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


func on_pause() -> void:
	_restore_mouse_cursor()


func on_resume() -> void:
	# skip the next frame to prevent accidental weapon fires
	# when interpreting a click that was meant for the previous scene
	_skip_frame = true
	_replace_mouse_cursor()


func _replace_mouse_cursor() -> void:
	cursor.set_visible(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _restore_mouse_cursor() -> void:
	cursor.set_visible(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _restore_cursor_outside_window() -> void:
	if get_viewport().get_visible_rect().has_point(get_viewport().get_mouse_position()):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _build_action_from_inputs() -> RobotCharacter.Action:
	var action: RobotCharacter.Action = RobotCharacter.Action.new()
	action.movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if Input.is_action_just_pressed(attack_key):
		action.attack = true

	action.aim_direction = (current_robot.get_global_mouse_position() - current_robot.global_position).normalized()
	
	return action


func _process_aim_target_inputs(aim_target: Node2D, _delta: float) -> void:
	if Input.is_action_just_pressed(interact_key):
		var interaction_target: Interaction = aim_target as Interaction
		# var interaction_target: Interaction = Util.find_child(aim_target, Interaction)
		if interaction_target: _process_interaction(interaction_target)
	elif Input.is_action_just_pressed(hack_key):
		var hack_target: Hack = aim_target as Hack
		# var hack_target: Hack = Util.find_child(aim_target, Hack)
		if hack_target: _process_hack(hack_target)


func _process_interaction(interaction_target: Interaction) -> void:
	interaction_target.interact(current_robot)


func _process_hack(hack_target: Hack) -> void:
	var result: Hack.Result = hack_target.hack(self)
	if result.hack_scene:
		_scene_manager.set_active_scene(result.hack_scene, true)


func _get_aim_target() -> Node2D:
	return current_robot.aim_raycast.get_collider()
