extends AnimatedSprite

onready var player = get_parent()

func _process(delta):
	if player.movement_direction == Vector2.RIGHT:
		flip_h = false
	if player.movement_direction == Vector2.LEFT:
		flip_h = true
	
	if player.is_on_floor():
		if abs(player.velocity.x) > 10:
			play("walk")
		else:
			play("idle")
	else:
		play("jump")
