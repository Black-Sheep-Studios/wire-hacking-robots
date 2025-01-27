class_name Hack

extends StaticBody2D


@onready var _parent_object: Node = get_parent()

@export var hack_scene: PackedScene
@export var fail_triggers: Array[Trigger]
@export var success_triggers: Array[Trigger]
@export var one_time: bool = false
@export var retry_on_failure: bool = true
@export var interaction_label: String = "Hack"

var _collider: CollisionShape2D
var _input_prompt: InputPrompt


func _ready() -> void:
	# if this is attached to a robot, it needs to late init after the robot
	# has created a collider
	if _parent_object is not RobotCharacter:
		init()
	
	if _parent_object.has_signal("died"):
		_parent_object.died.connect(_disable)

	_input_prompt = InputPrompt.find_or_create(_parent_object)
	_input_prompt.set_action(InputPrompt.Type.TERTIARY, InputPrompt.ActionType.HACK, interaction_label)


func init() -> void:
	set_collision_layer_value(Constants.CollisionLayers.MOVEMENT, false)
	set_collision_mask_value(Constants.CollisionLayers.MOVEMENT, false)
	set_collision_layer_value(Constants.CollisionLayers.INTERACTION, true)
	set_collision_mask_value(Constants.CollisionLayers.INTERACTION, false)
	set_collision_layer_value(Constants.CollisionLayers.BULLET, false)
	set_collision_mask_value(Constants.CollisionLayers.BULLET, false)
	_collider = _duplicate_parent_collider()


func hack(player_controller: PlayerRobotController) -> Result:
	var result = Result.new()

	if not player_controller.current_robot.can_do(RobotCharacter.Abilities.HACK):
		return result

	var hack_scene_instance: HackScene = hack_scene.instantiate()
	hack_scene_instance.hack_succeeded.connect(func() -> void:
		_on_success(player_controller)
		if one_time:
			_disable()
	)
	hack_scene_instance.hack_failed.connect(func() -> void:
		_on_failure(player_controller)
		if one_time or not retry_on_failure:
			_disable()
	)
	
	result.hack_scene = hack_scene_instance
	return result


func _on_success(player_controller: PlayerRobotController) -> void:
	for trigger in success_triggers:
		trigger.activate(player_controller)


func _on_failure(player_controller: PlayerRobotController) -> void:
	for trigger in fail_triggers:
		trigger.activate(player_controller)


func _duplicate_parent_collider() -> CollisionShape2D:
	var parent_collider: CollisionShape2D = Util.require_child(_parent_object, CollisionShape2D)
	var new_collider: CollisionShape2D = parent_collider.duplicate()
	new_collider.name = "HackCollider"
	add_child.call_deferred(new_collider)
	return new_collider


func _disable() -> void:
	_collider.disabled = true
	_input_prompt.unset_action(InputPrompt.Type.TERTIARY)


class Result:
	var hack_scene: HackScene
