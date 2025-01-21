class_name Bullet

extends CharacterBody2D


var speed: float
var direction: Vector2


func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()
