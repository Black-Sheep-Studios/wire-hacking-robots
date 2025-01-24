class_name RobotStats

extends Resource

@export var move_speed: int
@export var hit_points: float
@export var weaknesses: Array[Weapon.DamageType]
@export var resistances: Array[Weapon.DamageType]

@export var abilities: Array[RobotCharacter.Abilities]

@export var move_sound: AudioStream
@export var sprite: SpriteFrames
@export var collider_radius: float
@export var interact_reach_distance: float
