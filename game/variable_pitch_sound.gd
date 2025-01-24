class_name VariablePitchSound
extends AudioStreamPlayer2D


func _process(_delta: float) -> void:
	if not is_playing():
		return

	set_pitch_scale(TimeDilation.get_time_scale())

