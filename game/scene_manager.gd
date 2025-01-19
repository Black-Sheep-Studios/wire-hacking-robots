class_name SceneManager

extends Node


signal scene_changed(scene: Scene)

@export var start_scene: PackedScene


func _ready() -> void:
	if start_scene != null:
		set_active_scene(start_scene, true)


func get_active_scene() -> Scene:
	var active_scenes: Array[Scene] = get_active_scenes()
	if active_scenes.size() == 0:
		return null
	return active_scenes[0]


func get_active_scenes() -> Array[Scene]:
	var scenes: Array[Scene]
	for child in get_children():
		if child is Scene:
			scenes.append(child)
	return scenes


func set_active_scene(packed_scene: PackedScene, replace: bool = false) -> void:
	print("SceneManager.set_active_scene: ", packed_scene, " replace: ", replace)
	if replace: _free_scenes()

	var scene = _init_scene(packed_scene)
	move_child(scene, 0)
	scene_changed.emit(scene)


func pop_scene() -> void:
	var active_scenes: Array[Scene] = get_active_scenes()
	if active_scenes.size() == 0:
		return

	var scene = active_scenes[0]
	scene.queue_free()
	# TODO: a little inefficient to fetch the active scenes again
	scene_changed.emit(get_active_scene())


func _init_scene(packed_scene: PackedScene) -> Scene:
	var scene = packed_scene.instantiate()
	add_child(scene)
	scene.init(self)
	return scene


func _free_scenes() -> void:
	var active_scenes: Array[Scene] = get_active_scenes()
	for active_scene in active_scenes:
		active_scene.queue_free()
