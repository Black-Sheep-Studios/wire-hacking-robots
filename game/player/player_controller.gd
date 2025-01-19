class_name PlayerController

extends Node
## PlayerController is a base class for _any_ class that will be accessing the Input state.
## 
## They should _never_ implement a _process() or _physics_process() method, because the InputManager
## will be responsible for delegating processing time to them when it's appropriate by calling process()

var active: bool = true


func process(_delta: float) -> void:
	push_warning("Controller.process() not implemented")
