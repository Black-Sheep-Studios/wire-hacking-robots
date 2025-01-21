class_name ORGate
extends Component

func _eval_logic() -> void:
	var new_output = inputs.any( func(_input : Component) -> bool: return _input.output )
	if new_output != output:
		output = new_output
		output_changed.emit()
