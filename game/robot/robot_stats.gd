class_name RobotStats

extends Resource

@export var move_speed: int
@export var hit_points: float
@export var weaknesses: Array[Weapon.DamageType]
@export var resistances: Array[Weapon.DamageType]

@export var abilities: Array[RobotCharacter.Abilities] = [RobotCharacter.Abilities.HACK]

@export var move_sound: AudioStream
@export var move_sound_type: MovementSound.SoundType = MovementSound.SoundType.ONE_SHOT
@export var sprite: SpriteFrames
@export var collider_radius: float = 15
@export var interact_reach_distance: float = 25
