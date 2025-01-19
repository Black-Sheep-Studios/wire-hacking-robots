class_name Door

extends Interactable


@export var is_open: bool = false


func open() -> void:
	is_open = true
