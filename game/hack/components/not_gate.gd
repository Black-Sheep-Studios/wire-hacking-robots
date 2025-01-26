class_name NOTGate
extends Component

func _ready() -> void:
	super._ready()

	if inputs.size() != 1:
		push_warning("NOT gate with bad configuration: ", get_path())

func _evaluate_state() -> bool:
	return !inputs[0]
