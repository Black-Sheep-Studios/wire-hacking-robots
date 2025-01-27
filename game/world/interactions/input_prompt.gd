class_name InputPrompt
extends Node2D

enum ActionType {
	HACK,
	INTERACT,
}

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


# TODO: abstract sprites so we can show keyboard, mouse, controller depending on what's being used
@onready var _spritesheet: SpriteFrames = preload("res://assets/graphics/mouse_prompt.tres")

var _actions: Dictionary = {}


static func find_or_create(container: Node) -> InputPrompt:
	var prompt: InputPrompt = Util.find_child(container, InputPrompt)
	if not prompt:
		prompt = InputPrompt.new()
		prompt.name = "InputPrompt"
		container.add_child.call_deferred(prompt)
	return prompt


func _ready() -> void:
	set_visible(false)


func enable() -> void:
	if not is_visible():
		_update_actions()
		set_visible(true)


func disable() -> void:
	if is_visible():
		set_visible(false)


func set_action(input_type: Type, action_type: ActionType, label: String) -> void:
	var action = Action.new(input_type, action_type, label)
	_actions[input_type] = action


func unset_action(input_type: Type) -> void:
	_actions.erase(input_type)


func _update_actions() -> void:
	# remove existing prompts
	for child: Node in get_children():
		child.queue_free()

	var prompt_position: int = 0
	for input_type in Type.values():
		if not _actions.has(input_type): continue

		var action = _actions[input_type]

		var sprite: AnimatedSprite2D = AnimatedSprite2D.new()
		print(_spritesheet)
		sprite.frames = _spritesheet
		sprite.set_centered(false)
		sprite.play(input_action_names[input_type])
		sprite.position = Vector2(sprite_offset.x, (prompt_position * prompt_offset.y) + sprite_offset.y)
		add_child.call_deferred(sprite)

		var label: Label = Label.new()
		label.text = action.label
		label.position = Vector2(prompt_offset.x, prompt_position * prompt_offset.y)
		add_child.call_deferred(label)

		prompt_position += 1


class Action:
	var action_type: ActionType
	var input_type: Type
	var label: String

	@warning_ignore("shadowed_variable")
	func _init(input_type: Type, action_type: ActionType, label: String) -> void:
		self.action_type = action_type
		self.input_type = input_type
		self.label = label
