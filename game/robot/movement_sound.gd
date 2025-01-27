class_name MovementSound
extends Node2D

enum SoundType {
	LOOP,
	ONE_SHOT,
}

@onready var _parent_object: MovementObject = Util.require_parent(self, MovementObject)

var _sound_player: AudioStreamPlayer2D
var _continue_playing: bool = true
var _sound_type: SoundType


static func attach(node: Node, sound: AudioStreamPlayer2D, sound_type: SoundType) -> MovementSound:
	var movement_sound: MovementSound = MovementSound.new()
	movement_sound.init(sound_type, sound)
	movement_sound.name = "MovementSound"
	Util.attach(node, movement_sound)
	return movement_sound


func init(sound_type: SoundType, sound_player: AudioStreamPlayer2D) -> void:
	_sound_type = sound_type

	_sound_player = sound_player
	add_child(_sound_player)
	if _sound_type == SoundType.ONE_SHOT:
		_sound_player.finished.connect(_sound_finished)


func _process(_delta: float) -> void:
	match _sound_type:
		SoundType.LOOP:
			_process_loop_sound()
		SoundType.ONE_SHOT:
			_process_one_shot_sound()


func _process_one_shot_sound() -> void:
	if is_zero_approx(_parent_object.target_velocity.length()):
		_continue_playing = false
		return

	if not _sound_player.is_playing():
		_sound_player.play()
		_continue_playing = true


func _sound_finished() -> void:
	if _continue_playing:
		_sound_player.play()


func _process_loop_sound() -> void:
	if _object_is_moving() and !_sound_player.is_playing():
		_sound_player.play()
	elif not _object_is_moving() and _sound_player.is_playing():
		_sound_player.stop()



func _object_is_moving() -> bool:
	return not is_zero_approx(_parent_object.target_velocity.length())
