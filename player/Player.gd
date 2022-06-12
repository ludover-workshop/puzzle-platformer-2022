extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

export(float) var move_speed: float = 100
export(float) var gravity: float = 400
export(float) var jump_speed: float = 250

func _physics_process(delta):
	var movement_direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		movement_direction = Vector2.RIGHT
		$PlayerSprites.flip_h = false
	if Input.is_action_pressed("move_left"):
		movement_direction = Vector2.LEFT
		$PlayerSprites.flip_h = true
	
	if is_on_floor():
		if movement_direction != Vector2.ZERO:
			$PlayerSprites.play("walk")
		else:
			$PlayerSprites.play("idle")
	else:
		$PlayerSprites.play("jump")
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y -= jump_speed
		
	velocity.x = movement_direction.x * move_speed
	velocity.y = velocity.y + gravity * delta
		
	velocity = move_and_slide(velocity, Vector2.UP)
