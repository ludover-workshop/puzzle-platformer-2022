extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

export(float) var max_move_speed: float = 100
export(float) var move_acceleration: float = 500
export(float) var gravity: float = 600
export(float) var jump_speed: float = 250

var key_in_pocket = false

var movement_direction = Vector2.ZERO

onready var state_machine = $AnimationTree.get("parameters/playback")

onready var was_on_floor = is_on_floor()

var just_jumped = false

func _physics_process(delta):
	movement_direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		movement_direction = Vector2.RIGHT
	if Input.is_action_pressed("move_left"):
		movement_direction = Vector2.LEFT
		
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_speed
		just_jumped = true
		
	#velocity.x = clamp(velocity.x + movement_direction.x * move_acceleration * delta, -max_move_speed, max_move_speed)
	
	velocity.x = move_toward(velocity.x,  movement_direction.x * max_move_speed, move_acceleration * delta)
	
	velocity = velocity + Vector2.DOWN * gravity * delta

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	update_animation_tree()

func update_animation_tree():
	if(just_jumped):
		state_machine.travel("JumpStart")
	elif was_on_floor && is_on_floor():
		if abs(velocity.x) > 10 || movement_direction != Vector2.ZERO:
			state_machine.travel("Walking")
		else:
			state_machine.travel("Idle")
	elif !was_on_floor && is_on_floor():
		state_machine.travel("JumpLand")
	elif was_on_floor && !is_on_floor():
		state_machine.travel("JumpAir")
		
	was_on_floor = is_on_floor()
	just_jumped = false

func pickup_coin():
	print("pickup coin")
	
func has_key():
	return key_in_pocket	

func pickup_key():
	key_in_pocket = true
	print("pickup key")

func high_jump():
	velocity.y = -jump_speed * 1.3
	just_jumped = true

func damage_control():
	print("Death!")
	get_tree().reload_current_scene()


