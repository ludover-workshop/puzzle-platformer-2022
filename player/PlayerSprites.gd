extends AnimatedSprite

onready var player = get_parent()

func _process(delta):
	if player.movement_direction == Vector2.RIGHT:
		flip_h = false
	if player.movement_direction == Vector2.LEFT:
		flip_h = true
