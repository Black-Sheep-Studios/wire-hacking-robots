class_name PlayerRobotController
extends PlayerController


@export var _cursor_sprite: SpriteFrames
@export var current_robot: RobotCharacter

const attack_key: String = "primary_action"
const interact_key: String = "secondary_action"
const hack_key: String = "tertiary_action"

@onready var cursor: AnimatedSprite2D = _build_cursor()

var _skip_frame: bool = false
var _last_aim_target: Node2D


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
	_process_aim_target_prompts(aim_target)
	if aim_target: 
		_process_aim_target_inputs(aim_target, delta)

	var action: RobotCharacter.Action = _build_action_from_inputs()
	action.delta = delta

	current_robot.act(action)


func override_robot_from_hack(payload: Outcome.Payload) -> void:
	var robot: RobotCharacter = payload.target as RobotCharacter
	if not robot:
		push_error("PlayerRobotController tried to override a non-robot at ", payload.parent_object.get_path())
		return

	control_robot(robot)


func control_robot(robot: RobotCharacter) -> void:
	current_robot = robot
	if Util.find_child(current_robot, Weapon):
		cursor.play("weapon")
	else:
		cursor.play("default")


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

	if Input.is_action_pressed(attack_key):
		action.attack = true

	action.aim_direction = (current_robot.get_global_mouse_position() - current_robot.global_position).normalized()
	
	return action


func _process_aim_target_inputs(aim_target: Node2D, _delta: float) -> void:
	if Input.is_action_just_pressed(interact_key):
		var interaction_target: Interaction = aim_target as Interaction
		if interaction_target: _process_interaction(interaction_target)
	elif Input.is_action_just_pressed(hack_key):
		var hack_target: Hack = aim_target as Hack
		if hack_target: _process_hack(hack_target)


func _process_aim_target_prompts(aim_target: Node2D) -> void:
	if is_instance_valid(_last_aim_target) and aim_target != _last_aim_target:
		var last_action_prompt: InputPrompt = Util.find_sibling(_last_aim_target, InputPrompt)
		if last_action_prompt: last_action_prompt.disable()
	_last_aim_target = aim_target

	if aim_target:
		var input_prompt: InputPrompt = Util.find_sibling(aim_target, InputPrompt)
		if input_prompt:
			input_prompt.enable(self)


func _process_interaction(interaction_target: Interaction) -> void:
	interaction_target.interact(current_robot)


func _process_hack(hack_target: Hack) -> void:
	var result: Hack.InteractResult = hack_target.hack(self)
	if not result.hack_scene:
		push_error("PlayerRobotController tried to hack ", hack_target.get_path(), " but it did not return a hack scene")
		return

	_scene_manager.set_active_scene(result.hack_scene, true)


func _get_aim_target() -> Node2D:
	return current_robot.aim_raycast.get_collider()


func _build_cursor() -> AnimatedSprite2D:
	var new_cursor: AnimatedSprite2D = AnimatedSprite2D.new()
	new_cursor.frames = _cursor_sprite
	new_cursor.animation = "default"
	new_cursor.set_visible(false)
	new_cursor.set_centered(true)
	add_child.call_deferred(new_cursor)
	return new_cursor
