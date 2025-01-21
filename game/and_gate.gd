class_name ANDGate
extends Component

func _eval_logic() -> void:
	var new_output = inputs.all( func(_input : Component) -> bool: return _input.output )
	if new_output != output:
		output = new_output
		output_changed.emit()
