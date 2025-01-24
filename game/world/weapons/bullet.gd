class_name Bullet

extends MovementObject


var stats: WeaponStats
var shooter: Node


func init(initial_position: Vector2, initial_velocity: Vector2, weapon_origin: Node, weapon_stats: WeaponStats) -> void:
	set_global_position(initial_position)
	target_velocity = initial_velocity
	stats = weapon_stats
	self.shooter = weapon_origin

	collided.connect(_on_hit)


func _on_hit(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()

	if collider.has_method("take_damage"):
		collision.collider.take_damage(stats.damage, stats.damage_type)
	
	queue_free()
