extends RayCast2D

onready var player = get_parent()

func _process(delta):
	if player.movement_direction == Vector2.RIGHT:
		cast_to = Vector2(10, 0)
	if player.movement_direction == Vector2.LEFT:
		cast_to = Vector2(-10, 0)
