class_name RobotSprite
extends AnimatedSprite2D


@onready var _robot: RobotCharacter = Util.require_parent(self, RobotCharacter)


func _process(_delta: float) -> void:
	if _robot.dead:
		play("dead")
		return

	if _robot.aim_direction.x != 0:
		set_flip_h(_robot.aim_direction.x < 0)

	if _robot.movement_direction.length() > 0:
		play("move")
	else:
		play("idle")
