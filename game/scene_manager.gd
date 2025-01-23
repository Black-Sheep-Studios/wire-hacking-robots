class_name SceneManager

extends Node
## SceneManager is responsible for tracking the current stack of active Scenes in the game.
##
## Each scene it instantiates will be given a handle back to the SceneManager, allowing Scenes to:
## - Add a new scene to the top of the stack with set_active_scene(packed_scene_reference)
##   - showing the pause menu
##   - starting a minigame
## - Replace the entire current stack with a new scene with set_active_scene(packed_scene_reference, true)
##   - starting a new game
##   - returning to the main menu
## - Remove itself from the top of the stack with pop_scene(), which will return control to the previous scene
##   - closing the pause menu
##   - ending a minigame

signal scene_changed(scene: Scene)

@export var start_scene: PackedScene


func _ready() -> void:
	if not start_scene:
		push_error("SceneManager._ready: start_scene not set")
		return

	set_active_scene(start_scene.instantiate())


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


func set_active_scene(scene: Scene, pause: bool = false, replace: bool = false) -> void:
	if replace: _free_scenes()

	if pause:
		var active_scene: Scene = get_active_scene()
		if active_scene:
			active_scene.on_pause()
		TimeDilation.slow_time()

	add_child(scene)
	scene.init(self)
	scene_changed.emit(scene)


func pop_scene() -> void:
	var active_scenes: Array[Scene] = get_active_scenes()
	if active_scenes.size() <= 1:
		push_error("SceneManager.pop_scene: no scenes to pop")
		return

	var old_active_scene = active_scenes[active_scenes.size() - 1]
	old_active_scene.queue_free()

	var new_active_scene: Scene = get_active_scene()
	# TODO: this might not always be true, but it's a good assumption for now
	TimeDilation.unslow_time()
	new_active_scene.on_resume()
	scene_changed.emit(new_active_scene)


func _free_scenes() -> void:
	var active_scenes: Array[Scene] = get_active_scenes()
	for active_scene in active_scenes:
		active_scene.queue_free()
