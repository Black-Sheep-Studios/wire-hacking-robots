class_name Door

extends Node2D


@onready var sprite: AnimatedSprite2D = $Sprite
@export var open_trigger: Trigger

var is_open: bool = false


func _ready() -> void:
	open_trigger.activated.connect(_toggle)


func _toggle() -> void:
	is_open = !is_open
	print("Door ", get_path(), " is open:", is_open)
	if is_open:
		sprite.play("open")
	else:
		sprite.play("close")
