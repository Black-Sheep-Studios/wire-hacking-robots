class_name Weapon
extends Node

enum DamageType {
	KINETIC,
	ENERGY,
}


@onready var shooter: Node2D = get_parent()
@onready var container: Scene = Util.require_parent(self, Scene)

@export var stats: WeaponStats

@onready var _delay_timer: Timer = _init_delay_timer()
var cooldown: bool = false


func fire(direction: Vector2) -> void:
	if cooldown: return

	var bullet = stats.bullet_scene.instantiate()

	var initial_velocity = direction * stats.bullet_speed
	var initial_position = shooter.global_position + direction.normalized() * 50
	bullet.init(initial_position, initial_velocity, shooter, stats)

	container.add_child(bullet)
	cooldown = true
	_delay_timer.start()


func _init_delay_timer() -> Timer:
	_delay_timer = Timer.new()
	_delay_timer.set_wait_time(stats.fire_delay_seconds)
	_delay_timer.set_one_shot(true)
	_delay_timer.timeout.connect(func() -> void: 
		cooldown = false
	)
	add_child(_delay_timer)
	return _delay_timer
