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
	_scene_manager.scene_changed.connect(_on_scene_changed)


func _process(_delta: float) -> void:
	if current_controller == null: return

	current_controller.process(_delta)


func _on_scene_changed(scene: Scene) -> void:
	if scene == null:
		push_warning("InputManager._on_scene_changed: scene is null")
		return

	current_controller = scene.get_active_controller()

	if current_controller == null:
		push_warning("InputManager._on_scene_changed: current_controller is null")
		return

	current_controller.init(_scene_manager)
