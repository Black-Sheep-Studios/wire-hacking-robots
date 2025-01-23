class_name LogicIn
extends Component

@onready var TxtLabel = $InputText
@onready var InButton = $InputButton

@export var initial_state: bool = false


func _ready():
	InButton.button_up.connect(_toggle_output)


func initialize_state() -> void:
	output = initial_state
	state_initialized.emit()


func _toggle_output() -> void:
	_set_output(not output)
	output_changed.emit()


func _set_output(value: bool) -> void:
	output = value
	_update_text()


func _update_text() -> void:
	if output: TxtLabel.text = "1"
	else: TxtLabel.text = "0"


func _evaluate_state() -> bool:
	return output


