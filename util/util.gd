class_name Util

extends Object


static var null_lambda: Callable = func() -> void: pass


static func require_child(parent: Node, type: Variant) -> Node:
	var node: Node = find_child(parent, type)
	if node == null:
		push_error(parent.get_path(), " requires child ", type)
	return node


static func require_sibling(node: Node, type: Variant) -> Node:
	var sibling: Node = find_sibling(node, type)
	if sibling == null:
		push_error(node.get_path(), " requires sibling ", type)
	return sibling


static func require_parent(node: Node, type: Variant) -> Node:
	var parent: Node = find_parent(node, type)
	if parent == null:
		push_error(node.get_path(), " requires parent ", type)
	return parent


static func find_child(parent: Node, type: Variant) -> Node:
	var node: Node = (parent.get_children()
	.filter(func(child: Node) -> bool: 
		return is_instance_of(child, type)
	).pop_front())
	return node


static func find_sibling(node: Node, type: Variant) -> Node:
	return find_child(node.get_parent(), type)


static func find_parent(node: Node, type: Variant) -> Node:
	var parent: Node = node.get_parent()
	while parent != null:
		if is_instance_of(parent, type):
			return parent
		parent = parent.get_parent()
	return null


static func attach_sound_player(node: Node, sound: AudioStream) -> VariablePitchSound:
	var player: VariablePitchSound = VariablePitchSound.new()
	player.stream = sound
	node.add_child.call_deferred(player)
	return player


static func attach_one_shot_timer(node: Node, delay: float = 1.0, timeout: Callable = null_lambda) -> Timer:
	var timer: Timer = one_shot_timer(delay, timeout)
	node.add_child.call_deferred(timer)
	return timer


static func one_shot_timer(delay: float = 1.0, timeout: Callable = null_lambda) -> Timer:
	var timer: Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = delay
	if timeout != null_lambda:
		timer.timeout.connect(timeout)
	return timer


static func sort_by_distance_from(position: Vector2, nodes: Array[Node2D]) -> Array[Node2D]:
	var result: Array[Node2D] = nodes.duplicate()
	result.sort_custom(func(a: Node2D, b: Node2D) -> bool:
		return position.distance_squared_to(a.global_position) < position.distance_squared_to(b.global_position)
	)
	return result
