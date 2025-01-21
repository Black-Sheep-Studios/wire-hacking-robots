class_name MovementObject

extends CharacterBody2D

## We are using CharacterBody2D as a base class for all objects that can move
## because we do not want to full control over velocity of the object. This will
## allow us to change the timescale of movements without having to worry about
## the tick rate of the physics engine.

var is_slowed: bool = true
var target_velocity: Vector2


func _physics_process(_delta: float) -> void:
	if is_slowed:
		velocity = target_velocity * TimeDilation.get_time_scale()
	else:
		velocity = target_velocity

	move_and_slide()
