class_name RobotCharacter
extends MovementObject


enum Abilities {
	DOORS,
	HACK,
}

signal damaged
signal died

@export var _stats: RobotStats

var movement_direction: Vector2
var aim_direction: Vector2
@onready var hit_points: float = _stats.hit_points

@onready var sprite: AnimatedSprite2D = _build_sprite()
@onready var collider: CollisionShape2D = _build_collider()
@onready var aim_raycast: RayCast2D = _build_interact_raycast()
@onready var weapon: Weapon = Util.find_child(self, Weapon)
@onready var move_sound: MovementSound = MovementSound.attach(self, VariablePitchSound.from_stream(_stats.move_sound), _stats.move_sound_type)


func _ready() -> void:
	# some components need to be late initialized after the robot is ready
	for child in get_children():
		if child.has_method("init"):
			child.init()


func _process(_delta: float) -> void:
	if hit_points <= 0:
		died.emit()
		queue_free()
		return

	# TODO: extract this stuff to a class for the sprite
	if aim_direction.x != 0:
		sprite.flip_h = aim_direction.x < 0

	if movement_direction.length() > 0:
		sprite.play("move")
	else:
		sprite.play("idle")

	pass


func act(action: Action) -> void:
	movement_direction = action.movement_direction
	target_velocity = movement_direction * _stats.move_speed

	aim_direction = action.aim_direction
	if aim_direction != Vector2.ZERO:
		aim_raycast.rotation = aim_direction.angle() - PI / 2
	
	if action.attack and weapon:
		weapon.fire(aim_direction)


func take_damage(damage: float, _damage_type: Weapon.DamageType) -> void:
	var effective_damage: float = damage
	if _stats.weaknesses.has(_damage_type):
		effective_damage *= 2
	elif _stats.resistances.has(_damage_type):
		effective_damage /= 2
	hit_points -= effective_damage
	damaged.emit()


func can_do(ability: Abilities) -> bool:
	return _stats.abilities.has(ability)


func _build_collider() -> CollisionShape2D:
	var new_collider: CollisionShape2D = CollisionShape2D.new()
	var circle_shape: CircleShape2D = CircleShape2D.new()
	circle_shape.radius = _stats.collider_radius
	new_collider.shape = circle_shape
	add_child(new_collider)

	set_collision_layer_value(Constants.CollisionLayers.MOVEMENT, true)
	set_collision_mask_value(Constants.CollisionLayers.MOVEMENT, true)
	set_collision_layer_value(Constants.CollisionLayers.INTERACTION, false)
	set_collision_mask_value(Constants.CollisionLayers.INTERACTION, false)
	set_collision_layer_value(Constants.CollisionLayers.BULLET, true)
	set_collision_mask_value(Constants.CollisionLayers.BULLET, false)

	return new_collider


func _build_interact_raycast() -> RayCast2D:
	var raycast: RayCast2D = RayCast2D.new()
	raycast.collision_mask = Constants.CollisionLayers.INTERACTION
	raycast.add_exception(self)
	add_child.call_deferred(raycast)
	return raycast


func _build_sprite() -> AnimatedSprite2D:
	var new_sprite: AnimatedSprite2D = AnimatedSprite2D.new()
	new_sprite.frames = _stats.sprite
	add_child(new_sprite)
	return new_sprite


class Action:
	var delta: float
	var movement_direction: Vector2
	var aim_direction: Vector2
	var attack: bool
