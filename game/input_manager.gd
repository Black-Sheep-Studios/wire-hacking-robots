class_name InputManager

extends Node
## InputManager is responsible for delegating processing time to PlayerController instances, making
## sure that only one controller is receiving inputs at a time.
##
## It automatically tracks the currently active PlayerController by hooking into the SceneManager

var _scene_manager: SceneManager
var current_controller: PlayerController


func _ready() -> void:
	_scene_manager = Util.require_sibling(self, SceneManager)

	# NOTE: SceneManager could initialize before or after InputManager,
	# so we manually trigger the first scene change event here in case scene
	# is already set
	_on_scene_changed(_scene_manager.get_active_scene())
	_scene_manager.scene_changed.connect(_on_scene_changed)


func _process(_delta: float) -> void:
	if current_controller == null: return
	if current_controller.active == false: return

	current_controller.process(_delta)


func _on_scene_changed(scene: Scene) -> void:
	if scene == null:
		print("InputManager._on_scene_changed: scene is null")
		return

	print("InputManager._on_scene_changed: ", scene, " controller: ", scene.get_active_controller())
	current_controller = scene.get_active_controller()
