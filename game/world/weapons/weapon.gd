class_name Weapon
extends Node

enum DamageType {
	KINETIC,
	ENERGY,
}


@onready var shooter: Node2D = get_parent()
@onready var container: Scene = Util.require_parent(self, Scene)
@onready var _delay_timer: Timer = Util.attach_one_shot_timer(self, stats.fire_delay_seconds, _end_cooldown)
@onready var _fire_sound: AudioStreamPlayer2D = VariablePitchSound.attach(shooter, stats.fire_sound)

@export var stats: WeaponStats

var cooldown: bool = false
var _safe_spawn_distance: float


func init() -> void:
	_safe_spawn_distance = _calculate_safe_spawn_distance()


func fire(direction: Vector2) -> void:
	if cooldown: return

	var bullet = stats.bullet_scene.instantiate()

	var initial_velocity = direction * stats.bullet_speed
	var initial_position = shooter.global_position + direction.normalized() * _safe_spawn_distance
	bullet.init(initial_position, initial_velocity, shooter, stats)

	_fire_sound.play()

	container.add_child(bullet)
	cooldown = true
	_delay_timer.start()


# TODO: this is a bit of a guess. Seems okay for now, but it might not work if the hitbox on the bullet is really big?
func _calculate_safe_spawn_distance() -> float:
	var collider: CollisionShape2D = Util.find_child(shooter, CollisionShape2D)
	if not collider:
		return 0
	var shape_rect = collider.shape.get_rect()
	var radius = shape_rect.size.length() / 2
	return radius + 1


func _end_cooldown() -> void:
	cooldown = false
