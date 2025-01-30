class_name PlayerController

extends Node
## PlayerController is a base class for _any_ class that will be accessing the Input state.
## 
## They should _never_ implement a _process() or _physics_process() method, because the InputManager
## will be responsible for delegating processing time to them when it's appropriate by calling process()

var _scene_manager: SceneManager

@onready var _pause_menu_scene: PackedScene = preload("res://scenes/pause_menu.tscn")

func _init() -> void:
	# Controllers should always process inputs, even when the game is paused. The InputManager will
	# handle pausing of input processing when a controller is not active.
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS


func init(scene_manager: SceneManager) -> void:
	_scene_manager = scene_manager


func process(_delta: float) -> void:
	push_error(name, " does not override process!")
