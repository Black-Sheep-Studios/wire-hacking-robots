class_name XORGate
extends Component

func _eval_logic() -> void:
	var ones = 0
	for i in inputs:
		if i.output:
			ones += 1
	var new_output : bool = ( ones % 2 == 1 )
	if new_output != output:
		output = new_output
		output_changed.emit()
