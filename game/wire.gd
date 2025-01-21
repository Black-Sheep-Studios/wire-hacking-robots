class_name Wire
extends Component

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	if inputs.size() != 1:
		push_warning("wire with bad configuration!")
	inputs[0].output_changed.connect(_eval_logic)
	_eval_logic()

func _eval_logic() -> void:
	var new_output = inputs[0].output
	if new_output != output:
		output = new_output
		_update_color()
		output_changed.emit()

func _update_color():
	if output:
		self_modulate = Color(1.0, 1.0, 1.0)
	else:
		self_modulate = Color(0.2, 0.2, 0.2)
