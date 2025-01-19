class_name TestPlayerRobot

extends Node2D


@export var move_speed: float = 1000.0


func move(delta: float, direction: Vector2) -> void:
	var velocity = direction * move_speed
	position += velocity * delta
