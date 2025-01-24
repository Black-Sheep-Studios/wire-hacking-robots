class_name Weapon
extends Node

enum DamageType {
	KINETIC,
	ENERGY,
}


@onready var shooter: Node2D = get_parent()
@onready var container: Scene = Util.require_parent(self, Scene)
@onready var _delay_timer: Timer = Util.attach_one_shot_timer(self, stats.fire_delay_seconds, _end_cooldown)
@onready var _fire_sound: AudioStreamPlayer2D = Util.attach_sound_player(shooter, stats.fire_sound)

@export var stats: WeaponStats

var cooldown: bool = false


func fire(direction: Vector2) -> void:
	if cooldown: return

	var bullet = stats.bullet_scene.instantiate()

	var initial_velocity = direction * stats.bullet_speed
	var initial_position = shooter.global_position + direction.normalized() * 50
	bullet.init(initial_position, initial_velocity, shooter, stats)

	_fire_sound.play()

	container.add_child(bullet)
	cooldown = true
	_delay_timer.start()


func _end_cooldown() -> void:
	cooldown = false
