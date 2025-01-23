class_name ORGate
extends Component


func _evaluate_state() -> bool:
	return inputs.any(func(input: Component) -> bool:
		return input.output
	)
