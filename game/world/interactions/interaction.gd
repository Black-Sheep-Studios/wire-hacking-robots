class_name Interaction

extends StaticBody2D


@onready var parent_object: Node = get_parent()
@onready var collider: CollisionShape2D = _duplicate_parent_collider()


const interaction_collision_layer: int = 2


func _ready() -> void:
	set_collision_layer_value(interaction_collision_layer, true)


func interact(_interactor: RobotCharacter) -> void:
	push_error(name, " does not override interact!")


func conditions_satisified() -> bool:
	for child in get_children():
		if child is Condition:
			if not child.is_satisfied:
				return false
	
	return true


func _duplicate_parent_collider() -> CollisionShape2D:
	var parent_collider: CollisionShape2D = Util.require_child(parent_object, CollisionShape2D)
	var new_collider: CollisionShape2D = parent_collider.duplicate()
	add_child.call_deferred(new_collider)
	return new_collider
