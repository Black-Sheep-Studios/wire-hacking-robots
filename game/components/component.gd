class_name Component
extends Sprite2D

signal output_changed
signal state_initialized

@export var inputs: Array[Component]

var output: bool


func _ready() -> void:
	for input: Component in inputs:
		input.output_changed.connect(_upstream_changed)
		input.state_initialized.connect(func() -> void:
			_set_state(_evaluate_state())
			state_initialized.emit()
		)


func _evaluate_state() -> bool:
	push_error(name, " does not override _evaluate_state!")
	return false


func _set_state(new_state: bool) -> void:
	output = new_state


func _upstream_changed() -> void:
	var new_state: bool = _evaluate_state()
	if output != new_state:
		_set_state(new_state)
		output_changed.emit()
