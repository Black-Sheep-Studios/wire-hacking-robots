class_name WirehackScene
extends HackScene


func _ready() -> void:
	_initialize_components()


func _initialize_components() -> void:
	for input: LogicIn in _all_logic_inputs():
		input.initialize_state()


func _all_logic_inputs() -> Array[LogicIn]:
	var logic_ins: Array[LogicIn] = []
	for child in get_children():
		if child is LogicIn:
			logic_ins.append(child)
	return logic_ins
