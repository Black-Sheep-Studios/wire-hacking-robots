class_name WirehackScene
extends HackScene


func _ready() -> void:
	super._ready()
	_initialize_components()


func _initialize_components() -> void:
	for input: LogicIn in _all_logic_inputs():
		input.initialize_state()


func initialize_outcomes(labels: Array[String]) -> void:
	# TODO: distribute labels to buttons and remove this debug log
	print("Initializing outcomes: ", labels)
	pass


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
