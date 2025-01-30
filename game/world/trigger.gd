class_name Trigger
extends Node

signal activated


func activate(_interactor: Node = null) -> void:
	activated.emit()
