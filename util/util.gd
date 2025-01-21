class_name Util

extends Object


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


static func find_child(parent: Node, type: Variant) -> Node:
	var node: Node = (parent.get_children()
	.filter(func(child: Node) -> bool: 
		return is_instance_of(child, type)
	).pop_front())
	return node


static func find_sibling(node: Node, type: Variant) -> Node:
	return find_child(node.get_parent(), type)


static func sort_by_distance_from(position: Vector2, nodes: Array[Node2D]) -> Array[Node2D]:
	var result: Array[Node2D] = nodes.duplicate()
	result.sort_custom(func(a: Node2D, b: Node2D) -> bool:
		return position.distance_squared_to(a.global_position) < position.distance_squared_to(b.global_position)
	)
	return result
