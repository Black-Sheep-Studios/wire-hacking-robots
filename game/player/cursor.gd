class_name Cursor
extends Sprite2D


func _ready() -> void:
	set_centered(true)
	set_visible(false)


func _process(_delta: float) -> void:
	set_global_position(get_global_mouse_position())

