extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

export(float) var max_move_speed: float = 10
export(float) var move_acceleration: float = 400
export(float) var gravity: float = 400

var movement_direction = Vector2.LEFT

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if not collider.is_in_group("Player"):
			movement_direction *= -1
			scale.x *= -1
			
	if not $RayCast2D2.is_colliding():
		movement_direction *= -1
		scale.x *= -1
			
	velocity.x = move_toward(velocity.x,  movement_direction.x * max_move_speed, move_acceleration * delta)
	velocity = velocity + Vector2.DOWN * gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.damage_control()
