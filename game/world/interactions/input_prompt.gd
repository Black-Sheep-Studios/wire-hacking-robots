class_name InputPrompt
extends Node2D

enum Type {
	PRIMARY,
	SECONDARY,
	TERTIARY,
}

const input_action_names: Dictionary = {
	Type.PRIMARY: "primary_action",
	Type.SECONDARY: "secondary_action",
	Type.TERTIARY: "tertiary_action",
}

const sprite_offset: Vector2 = Vector2(0, 3)
const prompt_offset: Vector2 = Vector2(25, 0)
const prompt_spacing: int = 25


# TODO: abstract sprites so we can show keyboard, mouse, controller depending on what's being used
@onready var _spritesheet: SpriteFrames = preload("res://assets/graphics/mouse_prompt.tres")

var _actions: Dictionary = {}


static func find_or_create(container: Node) -> InputPrompt:
	# TODO: multiple calls to this in the same frame will create multiple prompts
	# because they have not been added to the tree yet. I'm not sure how to fix that yet
	# but it's only relevant if one object has multiple interactables.
	# There is probably a lesson in here about relying on the node tree for
	# state management.
	var prompt: InputPrompt = Util.find_child(container, InputPrompt)
	if not prompt:
		prompt = InputPrompt.new()
		prompt.name = "InputPrompt"
		container.add_child.call_deferred(prompt)
	return prompt


func _ready() -> void:
	set_visible(false)
	_init_rotation()


func enable(controller: PlayerRobotController) -> void:
	if not is_visible():
		_update_actions(controller)
		set_visible(true)


func disable() -> void:
	if is_visible():
		set_visible(false)


func register_interactable(input: Type, interactable: Interactable, label: String) -> void:
	_actions[input] = Action.new(interactable, input, label)


func _update_actions(controller: PlayerRobotController) -> void:
	# remove existing prompts
	for child: Node in get_children():
		child.queue_free()

	var prompt_index: int = 0
	for input_type in Type.values():
		print(get_path(), " Actions while updating: ", _actions)
		if not _actions.has(input_type): continue

		var action: Action = _actions[input_type]
		if not action.interactable.can_interact(controller.current_robot): continue

		var prompt_position: Vector2 = Vector2(0, prompt_index * prompt_spacing)
		_build_prompt(action.input, _spritesheet, action.label, prompt_position)

		prompt_index += 1


func _build_prompt(input_type: Type, sprite_frames: SpriteFrames, label: String, prompt_position: Vector2) -> void:
		print(get_path(), " Building prompt for ", input_type, " at ", prompt_position)
		var sprite_node: AnimatedSprite2D = AnimatedSprite2D.new()
		sprite_node.frames = sprite_frames
		sprite_node.set_centered(false)
		sprite_node.play(input_action_names[input_type])
		sprite_node.position = Vector2(prompt_position.x + sprite_offset.x, prompt_position.y + sprite_offset.y)
		add_child.call_deferred(sprite_node)

		var label_node: Label = Label.new()
		label_node.text = label
		label_node.position = Vector2(prompt_position.x + prompt_offset.x, prompt_position.y + prompt_offset.y)
		add_child.call_deferred(label_node)


# Kind of a funky hack, but the goal is for these prompts to be oriented right-side up
# regardless of the parent's rotation, so we're just traversing up the tree to the root,
# undoing rotations as we go.
func _init_rotation() -> void:
	var next_parent: Node = get_parent()
	while next_parent:
		if next_parent is Node2D:
			rotate(-next_parent.rotation)
		next_parent = next_parent.get_parent()


class Action:
	var label: String
	var input: Type
	var interactable: Interactable

	@warning_ignore("SHADOWED_VARIABLE")
	func _init(interactable: Interactable, input: Type, label: String) -> void:
		self.interactable = interactable
		self.label = label
		self.input = input
