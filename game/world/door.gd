class_name Door

extends Node2D


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var movement_collider: CollisionShape2D = $MovementCollider
@export var open_trigger: Trigger

@export var open_sound: AudioStream
@onready var _open_sound_player: AudioStreamPlayer2D = Util.attach_sound_player(self, open_sound)

var is_open: bool = false
var is_moving: bool = false


func _ready() -> void:
	open_trigger.activated.connect(_toggle)
	sprite.animation_finished.connect(_end_cooldown)


func _toggle() -> void:
	if is_open:
		close()
	else:
		open()


func open() -> void:
	if is_open or is_moving:
		return

	is_moving = true
	_open_sound_player.play()
	sprite.play("open")
	movement_collider.disabled = true
	is_open = true


func _end_cooldown() -> void:
	is_moving = false


func close() -> void:
	if not is_open or is_moving:
		return

	is_moving = true
	_open_sound_player.play()
	sprite.play_backwards("open")
	movement_collider.disabled = false
	is_open = false
