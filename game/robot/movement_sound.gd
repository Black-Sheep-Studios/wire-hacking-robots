class_name MovementSound
extends Node2D


@onready var _sound_player: AudioStreamPlayer2D = Util.require_child(self, AudioStreamPlayer2D)
@onready var _parent: MovementObject = Util.require_parent(self, MovementObject)


static func attach(node: Node, sound: AudioStreamPlayer2D) -> MovementSound:
	var movement_sound: MovementSound = MovementSound.new()
	movement_sound.add_child(sound)
	Util.attach(node, movement_sound)
	return movement_sound


func _process(_delta: float) -> void:
	if is_zero_approx(_parent.target_velocity.length()):
		_sound_player.stop()

	if not _sound_player.is_playing():
		_sound_player.play()
