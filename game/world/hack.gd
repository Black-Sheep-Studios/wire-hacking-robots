class_name Hack

extends StaticBody2D


@export var hack_scene: PackedScene
@export var fail_triggers: Array[Trigger]
@export var success_triggers: Array[Trigger]

@onready var parent_object: Node = get_parent()
@onready var collider: CollisionShape2D = _duplicate_parent_collider()


const interaction_collision_layer: int = 2


func _ready() -> void:
	set_collision_layer_value(interaction_collision_layer, true)


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


func _duplicate_parent_collider() -> CollisionShape2D:
	var parent_collider: CollisionShape2D = Util.require_child(parent_object, CollisionShape2D)
	var new_collider: CollisionShape2D = parent_collider.duplicate()
	add_child.call_deferred(new_collider)
	return new_collider


class Result:
	var hack_scene: HackScene
