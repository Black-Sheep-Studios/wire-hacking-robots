class_name Interactable
extends StaticBody2D

@export var interaction_label_override: String

@onready var parent_object: Node = get_parent()

var collider: CollisionShape2D
var enabled: bool = true

var _input_prompt: InputPrompt


func _ready() -> void:
	set_collision_layer_value(Constants.CollisionLayers.MOVEMENT, false)
	set_collision_mask_value(Constants.CollisionLayers.MOVEMENT, false)
	set_collision_layer_value(Constants.CollisionLayers.INTERACTION, true)
	set_collision_mask_value(Constants.CollisionLayers.INTERACTION, false)
	set_collision_layer_value(Constants.CollisionLayers.BULLET, false)
	set_collision_mask_value(Constants.CollisionLayers.BULLET, false)

	var interaction_label: String
	if interaction_label_override:
		interaction_label = interaction_label_override
	else:
		interaction_label = _interact_label()
	
	_input_prompt = InputPrompt.find_or_create(parent_object)
	_input_prompt.register_interactable(_interact_input(), self, interaction_label)

	# If the parent has a collider, then we can init. Otherwise, we'll save that for a late init
	# at which point the parent is responsible for calling init on its children
	var parent_collider = Util.find_child(parent_object, CollisionShape2D)
	if parent_collider:
		init()

	if parent_object.has_signal("died"):
		parent_object.died.connect(disable)


func init() -> void:
	collider = _duplicate_parent_collider()


func can_interact(_interactor: RobotCharacter) -> bool:
	push_warning("Interactable ", get_path(), " does not override can_interact!")
	return false


func conditions_satisified() -> bool:
	for child in get_children():
		if child is Condition:
			if not child.is_satisfied:
				return false
	
	return true


func enable() -> void:
	enabled = true
	collider.disabled = false


func disable() -> void:
	enabled = false
	collider.disabled = true


func _duplicate_parent_collider() -> CollisionShape2D:
	var parent_collider: CollisionShape2D = Util.require_child(parent_object, CollisionShape2D)
	var new_collider: CollisionShape2D = parent_collider.duplicate()
	add_child.call_deferred(new_collider)
	return new_collider


func _interact_label() -> String:
	push_warning("Interactable ", get_path(), " does not override _interact_label!")
	return "Interact"


func _interact_input() -> InputPrompt.Type:
	push_warning("Interactable ", get_path(), " does not override _interact_input!")
	return InputPrompt.Type.SECONDARY
