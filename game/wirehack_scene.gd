class_name WirehackScene
extends HackScene


func _ready() -> void:
	_initialize_components()


func _initialize_components() -> void:
	for input: LogicIn in _all_logic_inputs():
		input.initialize_state()
	for output: LogicOut in _all_logic_outputs():
		output.output_changed.connect(_check_for_success)


func _check_for_success() -> void:
	for output: LogicOut in _all_logic_outputs():
		if not output.correct_output():
			return
	_on_success()


func _all_logic_inputs() -> Array[LogicIn]:
	var logic_ins: Array[LogicIn] = []
	for child in get_children():
		if child is LogicIn:
			logic_ins.append(child)
	return logic_ins


func _all_logic_outputs() -> Array[LogicOut]:
	var logic_outs: Array[LogicOut] = []
	for child in get_children():
		if child is LogicOut:
			logic_outs.append(child)
	return logic_outs
