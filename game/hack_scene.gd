class_name HackScene
extends Scene


signal outcome_triggered(index: Outcome.Index)

@onready var _player_hack_controller: PlayerHackController = Util.require_child(self, PlayerHackController)


func _ready() -> void:
	# piggy back off our own signal to let the scene manager know that this scene is done
	outcome_triggered.connect(func(_index: Outcome.Index) -> void:
		_scene_manager.pop_scene()
	)


func trigger_failure() -> void:
	outcome_triggered.emit(Outcome.Index.Failure)


func trigger_outcome_one() -> void:
	outcome_triggered.emit(Outcome.Index.One)


func trigger_outcome_two() -> void:
	outcome_triggered.emit(Outcome.Index.Two)


func trigger_outcome_three() -> void:
	outcome_triggered.emit(Outcome.Index.Three)


func trigger_outcome_four() -> void:
	outcome_triggered.emit(Outcome.Index.Four)


func get_active_controller() -> PlayerController:
	return _player_hack_controller
