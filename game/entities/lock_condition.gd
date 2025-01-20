class_name LockCondition

extends Condition


func _ready() -> void:
	for child in get_children():
		if child is Trigger:
			child.activated.connect(unlock)


func unlock() -> void:
	is_satisfied = true
