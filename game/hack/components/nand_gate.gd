class_name NANDGate
extends Component


func _evaluate_state() -> bool:
	return !inputs.all(func(input: Component) -> bool: 
		return input.output
	)
