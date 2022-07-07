class_name Fx
extends Object

static func spawn(fx: PackedScene, spawner: Node2D, offset: Vector2 = Vector2.ZERO):
	var fxNode = fx.instance()
	fxNode.position = spawner.position + offset
	spawner.get_parent().add_child(fxNode)
	return fxNode
