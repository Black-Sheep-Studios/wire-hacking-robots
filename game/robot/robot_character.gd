class_name RobotCharacter

extends MovementObject


enum Abilities {
	DOORS,
	HACK,
}

@export var _stats: RobotStats
@export var _abilities: Array[Abilities]

var movement_direction: Vector2
var aim_direction: Vector2

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var aim_raycast: RayCast2D = $AimRaycast


func _ready() -> void:
	aim_raycast.add_exception(self)


func _process(_delta: float) -> void:
	# TODO: extract this stuff to a class for the sprite
	if aim_direction.x != 0:
		sprite.flip_h = aim_direction.x < 0

	if movement_direction.length() > 0:
		sprite.play("move")
	else:
		sprite.play("idle")

	pass


func act(action: Action) -> ActionResult:
	var result: ActionResult = ActionResult.new()

	movement_direction = action.movement_direction
	target_velocity = movement_direction * _stats.move_speed

	if action.interact_target: 
		result.interact_result = _interact(action.interact_target)
	
	aim_direction = action.aim_direction
	if aim_direction != Vector2.ZERO:
		aim_raycast.rotation = aim_direction.angle()
	
	return result


func can_do(ability: Abilities) -> bool:
	return _abilities.has(ability)


func _interact(target: Interaction) -> Interaction.Result:
	return target.interact(self)


class Action:
	var delta: float
	var movement_direction: Vector2
	var aim_direction: Vector2
	var interact_target: Interaction
	var attack: bool
	var hack: bool


class ActionResult:
	var interact_result: Interaction.Result
