class_name Wire
extends Component


func _ready() -> void:
	super._ready()

	if inputs.size() != 1:
		push_warning("wire with bad configuration: ", get_path())


func _evaluate_state() -> bool:
	return inputs[0].output


func _set_state(new_state: bool) -> void:
	super._set_state(new_state)
	_update_color()


func _update_color():
	if output:
		self_modulate = Color(1.0, 1.0, 1.0)
	else:
		self_modulate = Color(0.2, 0.2, 0.2)
