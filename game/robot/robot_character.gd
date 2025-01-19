class_name RobotCharacter

extends CharacterBody2D


enum Capabilities {
	DOORS,
}

@export var _stats: RobotStats
@export var _capabilities: Array[Capabilities]


func _ready() -> void:
	if not _stats:
		push_error("RobotCharacter is missing stats! %s" % get_path())


func _physics_process(_delta: float) -> void:
	move_and_slide()


func act(action: Action) -> void:
	set_velocity(action.movement_direction * _stats.move_speed)
	if action.interact_target: _interact(action.interact_target)


func _interact(target: Node2D) -> void:
	if target is Door:
		if Capabilities.DOORS in _capabilities:
			target.open()


class Action:
	var movement_direction: Vector2
	var interact_target: Node2D
