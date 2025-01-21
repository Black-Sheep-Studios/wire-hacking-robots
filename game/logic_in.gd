class_name LogicIn
extends Component

@onready var TxtLabel = $InputText
@onready var InButton = $InputButton

@export var initial_state : bool = false

func _ready():
	InButton.button_up.connect(_toggle_button)
	output = initial_state
	_update_text()
	output_changed.emit()

func _toggle_button() -> void:
	output = !output
	_update_text()
	output_changed.emit()

func _update_text() -> void:
	if output: TxtLabel.text = "1"
	else: TxtLabel.text = "0"
