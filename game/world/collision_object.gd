class_name CollisionObject
extends MovementObject

## CollisionObject is a variation on MovementObject that emits a signal when it collides with something.
## Note that this does not use move_and_slide(), so it's probably best suited to things that disappear
## on collision, like bullets.

signal collided(collision: KinematicCollision2D)


func _physics_process(_delta: float) -> void:
	if is_slowed:
		velocity = target_velocity * TimeDilation.get_time_scale()
	else:
		velocity = target_velocity

	var collision: KinematicCollision2D = move_and_collide(velocity * _delta)
	if collision:
		collided.emit(collision)
