class_name Menu

extends Scene


var _player_menu_controller: PlayerMenuController


func _init() -> void:
	# menus should still animate and process normally when the game is paused
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS


func _ready() -> void:
	_player_menu_controller = Util.require_child(self, PlayerMenuController)


func get_active_controller() -> PlayerController:
	return _player_menu_controller
