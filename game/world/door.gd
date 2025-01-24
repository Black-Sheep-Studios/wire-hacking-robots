class_name Door

extends Node2D


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var movement_collider: CollisionShape2D = $MovementCollider
@export var open_trigger: Trigger

@export var open_sound: AudioStream
@onready var _open_sound_player: AudioStreamPlayer2D = Util.attach_sound_player(self, open_sound)

var is_open: bool = false


func _ready() -> void:
	open_trigger.activated.connect(_toggle)


func _toggle() -> void:
	if is_open:
		close()
	else:
		open()


func open() -> void:
	if is_open:
		return

	_open_sound_player.play()
	sprite.play("open")
	movement_collider.disabled = true


func close() -> void:
	if not is_open:
		return

	sprite.play_backwards("open")
	movement_collider.disabled = false
