class_name Scene

extends Node

var _scene_manager: SceneManager


func init(scene_manager: SceneManager) -> void:
	_scene_manager = scene_manager


func get_active_controller() -> PlayerController:
	push_error("implement get_active_controller() in derived class")
	return null


func pause() -> void:
	get_tree().paused = true


func unpause() -> void:
	get_tree().paused = false
