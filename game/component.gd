class_name Component
extends Sprite2D

signal output_changed

@export var inputs: Array[Component]

var output : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in inputs:
		i.output_changed.connect(_eval_logic)

func _eval_logic() -> void:
	pass
