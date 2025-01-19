class_name Util

extends Object


static func require_child(parent: Node, type) -> Node:
	var node: Node = find_child(parent, type)
	if node == null:
		push_error("Required child not found")
	return node


static func require_sibling(node: Node, type) -> Node:
	var sibling: Node = find_sibling(node, type)
	if sibling == null:
		push_error("Required sibling not found")
	return sibling


static func find_child(parent: Node, type) -> Node:
	var node: Node = (parent.get_children()
	.filter(func(child: Node) -> bool: 
		return is_instance_of(child, type)
	).pop_front())
	return node


static func find_sibling(node: Node, type) -> Node:
	return find_child(node.get_parent(), type)
