class_name RobotCharacter

extends MovementObject


enum Abilities {
	DOORS,
	HACK,
}

@export var _stats: RobotStats
@export var _abilities: Array[Abilities]

var movement_direction: Vector2
var aim_direction: Vector2

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var aim_raycast: RayCast2D = $AimRaycast
@onready var weapon: Weapon
@onready var _move_sound: AudioStreamPlayer2D = _init_move_sound()


func _ready() -> void:
	aim_raycast.add_exception(self)
	weapon = Util.find_child(self, Weapon)


func _process(_delta: float) -> void:
	# TODO: extract this stuff to a class for the sprite
	if aim_direction.x != 0:
		sprite.flip_h = aim_direction.x < 0

	if movement_direction.length() > 0:
		_move_sound.play()
		sprite.play("move")
	else:
		_move_sound.stop()
		sprite.play("idle")

	pass


func act(action: Action) -> void:
	movement_direction = action.movement_direction
	target_velocity = movement_direction * _stats.move_speed

	aim_direction = action.aim_direction
	if aim_direction != Vector2.ZERO:
		aim_raycast.rotation = aim_direction.angle()
	
	if action.attack and weapon:
		weapon.fire(aim_direction)


func can_do(ability: Abilities) -> bool:
	return _abilities.has(ability)


func _init_move_sound() -> AudioStreamPlayer2D:
	_move_sound = VariablePitchSound.new()
	_move_sound.stream = _stats.move_sound
	add_child.call_deferred(_move_sound)
	return _move_sound


class Action:
	var delta: float
	var movement_direction: Vector2
	var aim_direction: Vector2
	var attack: bool
