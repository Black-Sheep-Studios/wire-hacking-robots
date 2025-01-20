class_name Trigger

extends Node

signal activated

func activate() -> void:
	activated.emit()
