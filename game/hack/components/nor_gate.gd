class_name NORGate
extends Component


func _evaluate_state() -> bool:
	return !inputs.any(func(input: Component) -> bool:
		return input.output
	)
