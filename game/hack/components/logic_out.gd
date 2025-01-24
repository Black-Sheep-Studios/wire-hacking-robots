class_name LogicOut
extends Component

@onready var TxtLabel = $OutputText

@export var initial_state : bool = false
@export var desired_state : bool = true

func _toggle_output() -> void:
	_set_state(not output)
	output_changed.emit()


func _set_state(value: bool) -> void:
	output = value
	_update_text()


func _update_text() -> void:
	if output: TxtLabel.text = "1"
	else: TxtLabel.text = "0"
	if output == desired_state:
		TxtLabel.set("theme_override_colors/font_color",Color(0.0,1.0,0.0))
	else:
		TxtLabel.set("theme_override_colors/font_color",Color(1.0,1.0,1.0))


func _evaluate_state() -> bool:
	var out : bool = inputs[0].output
	if out != output: _toggle_output()
	return out
