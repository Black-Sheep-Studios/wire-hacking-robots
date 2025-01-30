class_name Outcome
extends Node


enum Index {
	Failure = -1,
	One = 0,
	Two = 1,
	Three = 2,
	Four = 3,
}

signal triggered(payload: Payload)

@export var outcome_label: String
@export var failure: bool = false


func trigger(payload: Payload) -> void:
	triggered.emit(payload)


class Payload:
	var player_controller: PlayerRobotController
	var target: Node

