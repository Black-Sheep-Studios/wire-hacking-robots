class_name TargetCamera

extends Camera2D


@export var target: Node2D
@export var tracking_strength: float = 0.2


func _ready() -> void:
	position = target.global_position


func _process(_delta: float) -> void:
	position = target.global_position.lerp(position, tracking_strength)
