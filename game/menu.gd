class_name Menu

extends Scene


@onready var _player_menu_controller: PlayerMenuController = Util.require_child(self, PlayerMenuController)


func _init() -> void:
	# menus should still animate and process normally when the game is paused
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS


func get_active_controller() -> PlayerController:
	return _player_menu_controller
