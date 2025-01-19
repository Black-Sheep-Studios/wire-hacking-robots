class_name RobotCharacter

extends CharacterBody2D


enum Abilities {
	DOORS,
	HACK,
}

@export var _stats: RobotStats
@export var _abilities: Array[Abilities]

@onready var interaction_reach_area: DetectionArea = $InteractionReachArea


func _ready() -> void:
	if not _stats:
		push_error("RobotCharacter is missing stats! %s" % get_path())


func _physics_process(_delta: float) -> void:
	move_and_slide()


func act(action: Action) -> ActionResult:
	var result: ActionResult = ActionResult.new()

	set_velocity(action.movement_direction * _stats.move_speed)

	if action.interact_target: 
		result.interact_result = _interact(action.interact_target)
	
	return result


func can_reach(target: Node2D) -> bool:
	return interaction_reach_area.get_overlapping_bodies().has(target)


func can_do(ability: Abilities) -> bool:
	return _abilities.has(ability)


func _interact(target: Node2D) -> Interactable.Result:
	return target.interact(self)



class Action:
	var delta: float
	var movement_direction: Vector2
	var aim_direction: Vector2
	var interact_target: Node2D
	var attack: bool


class ActionResult:
	var interact_result: Interactable.Result
