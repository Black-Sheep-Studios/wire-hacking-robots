class_name VariablePitchSound
extends AudioStreamPlayer2D


static func attach(node: Node, sound: AudioStream) -> VariablePitchSound:
	var sound_player: VariablePitchSound = VariablePitchSound.new()
	sound_player.stream = sound
	Util.attach(node, sound_player)
	return sound_player


static func from_stream(new_stream: AudioStream) -> VariablePitchSound:
	var sound: VariablePitchSound = VariablePitchSound.new()
	sound.stream = new_stream
	return sound


func _process(_delta: float) -> void:
	if not is_playing():
		return

	# apply time dilation as pitch scale, but to a minimum of 0.5
	var pitch_variance: float = TimeDilation.get_time_scale() * 0.5
	set_pitch_scale(0.5 + pitch_variance)

