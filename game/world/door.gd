class_name Door

extends Node2D


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var movement_collider: CollisionShape2D = $MovementCollider
@export var open_trigger: Trigger

var is_open: bool = false


func _ready() -> void:
	open_trigger.activated.connect(_toggle)


func _toggle() -> void:
	if is_open:
		close()
	else:
		open()
	print("Door ", get_path(), " is open:", is_open)


func open() -> void:
	if is_open:
		return

	sprite.play("open")
	movement_collider.disabled = true


func close() -> void:
	if not is_open:
		return

	sprite.play("close")
	movement_collider.disabled = false
