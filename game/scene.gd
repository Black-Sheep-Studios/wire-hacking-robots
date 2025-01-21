class_name Scene

extends Node
## Scene is the base class for anything that should be managed by the SceneManager, which
## includes menus, minigames, and the main overworld map.
## 
## All Scenes will have some kind of PlayerController that will be responsible for processing
## inputs (otherwise the game will soft lock), and this should be returned by an implementation 
## of get_active_controller().

var _scene_manager: SceneManager


func init(scene_manager: SceneManager) -> void:
	_scene_manager = scene_manager


func get_active_controller() -> PlayerController:
	push_error(name, " does not override get_active_controller!")
	return null
