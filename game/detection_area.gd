class_name DetectionArea

extends Area2D


func get_interactables() -> Array[Interactable]:
	var interactables: Array[Interactable] = []
	for body in get_overlapping_bodies():
		var interactable: Interactable = body as Interactable
		if interactable != null: 
			interactables.append(interactable)
	return interactables
