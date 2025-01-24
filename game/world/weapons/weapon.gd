class_name Weapon
extends Node

enum DamageType {
	KINETIC,
	ENERGY,
}


@onready var shooter: Node2D = get_parent()
@onready var container: Scene = Util.require_parent(self, Scene)

@export var stats: WeaponStats


func fire(direction: Vector2) -> void:
	var bullet = stats.bullet_scene.instantiate()

	var initial_velocity = direction * stats.bullet_speed
	var initial_position = shooter.global_position + direction.normalized() * 50
	bullet.init(initial_position, initial_velocity, shooter, stats)

	container.add_child(bullet)
