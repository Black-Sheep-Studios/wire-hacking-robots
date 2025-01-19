class_name Interactable

extends Node2D


func interact(_interactor: Node2D) -> Result:
	push_error("Interactable is missing interact implementation! %s" % get_path())
	return null


class Result:
	# Type is used to signal back to the interactor that something else needs to happen 
	# after the interaction, e.g. starting a minigame or loading a new level
	enum Type {
		TERMINAL, # the interaction resolves itself, nothing else needs to happen
		WIREHACK, # start a wirehack minigame
		CODEHACK, # start a codehack minigame
	}

	var type: Type = Type.TERMINAL
	var success: bool = false
	var minigame: PackedScene
