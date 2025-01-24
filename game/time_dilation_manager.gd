class_name TimeDilationManager

extends Node


@export var normal_time_scale: float = 1.0
@export var slow_time_scale: float = 0.1
@export var time_transition_factor: float = 0.2

var time_scale: float = normal_time_scale
var target_time_scale: float = normal_time_scale

@onready var _dilation_timer: Timer = Util.attach_one_shot_timer(self, 0.0, unslow_time)


func _process(_delta: float) -> void:
	if time_scale != target_time_scale:
		time_scale = lerpf(time_scale, target_time_scale, time_transition_factor)


func get_time_scale() -> float:
	return time_scale


func slow_time_for(duration: float) -> void:
	slow_time()
	_dilation_timer.start(duration)


func slow_time() -> void:
	target_time_scale = slow_time_scale


func unslow_time() -> void:
	target_time_scale = normal_time_scale
