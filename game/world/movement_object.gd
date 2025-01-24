class_name MovementObject
extends CharacterBody2D

## MovementObject is a base class for all objects that can move.
##
## It gives us full control over the velocity of objects, so we can change the
## timescale of movement without having to worry about the tick rate of the
## physics engine.
##
## This means that any object that inherits from this class should not interact
## directly with `velocity`, but instead use `target_velocity` to set its desired
## velocity.
##
## If an object should be exempt from time dilation, set `is_slowed` to `false`.

var is_slowed: bool = true
var target_velocity: Vector2

signal collided(collision: KinematicCollision2D)


func _physics_process(_delta: float) -> void:
	if is_slowed:
		velocity = target_velocity * TimeDilation.get_time_scale()
	else:
		velocity = target_velocity

	var collision: KinematicCollision2D = move_and_collide(velocity * _delta)
	if collision:
		collided.emit(collision)
