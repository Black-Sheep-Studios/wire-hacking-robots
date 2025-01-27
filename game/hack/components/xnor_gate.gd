class_name XNORGate
extends Component


func _evaluate_state() -> bool:
	var ones : int = 0
	for input: Component in inputs:
		if input.output:
			ones += 1

	return ones % 2 == 0
