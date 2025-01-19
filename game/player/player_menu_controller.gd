class_name PlayerMenuController

extends PlayerController


func process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		_scene_manager.pop_scene()
