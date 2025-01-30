class_name PlayerHackController

extends PlayerController


func process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		var pause_scene: Scene = _pause_menu_scene.instantiate()
		_scene_manager.set_active_scene(pause_scene, true)
		return
