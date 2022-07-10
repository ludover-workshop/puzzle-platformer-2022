extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

export(float) var max_move_speed: float = 100
export(float) var move_acceleration: float = 500
export(float) var gravity: float = 600
export(float) var jump_speed: float = 250
export(int) var max_extra_jumps: int = 0
export(int) var enable_wall_jump: bool = true
export(int) var wall_jump_force: int = 200


signal death
signal pick_up_key

var key_in_pocket = false

var movement_direction = Vector2.ZERO
var can_move = true

onready var state_machine = $AnimationTree.get("parameters/playback")

onready var was_on_floor = is_on_floor()
onready var wall_jump_ray =$WallJumpRay

var just_jumped = false

var extra_jumps = max_extra_jumps

const JumpLandScene = preload("res://fx/JumpLandParticles.tscn")

func _physics_process(delta):
	movement_direction = Vector2.ZERO
	
	if can_move and Input.is_action_pressed("move_right"):
		movement_direction = Vector2.RIGHT
	if can_move and Input.is_action_pressed("move_left"):
		movement_direction = Vector2.LEFT

	var can_wall_jump = wall_jump_ray.is_colliding()
	var can_jump = is_on_floor() or extra_jumps > 0 or can_wall_jump 
	if Input.is_action_just_pressed("jump") && can_jump:
		velocity.y = -jump_speed
		just_jumped = true
		
		if not is_on_floor():
			if can_wall_jump:
				# wall jump
				if wall_jump_ray.cast_to.x > 0:
					velocity.x -= wall_jump_force
					var scene = Fx.spawn(JumpLandScene, self, Vector2(10, 10))
					scene.rotation_degrees = 120
				else:
					var scene = Fx.spawn(JumpLandScene, self, Vector2(-10, 10))
					scene.rotation_degrees = -120
					velocity.x += wall_jump_force	
			else:
				# extra jump
				extra_jumps -= 1
		
	#velocity.x = clamp(velocity.x + movement_direction.x * move_acceleration * delta, -max_move_speed, max_move_speed)
	
	velocity.x = move_toward(velocity.x,  movement_direction.x * max_move_speed, move_acceleration * delta)
	
	velocity = velocity + Vector2.DOWN * gravity * delta

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	update_animation_tree()

func spawn_jump_land_particles():
	if $GroundParticlesRay.is_colliding():
		Fx.spawn(JumpLandScene, self, Vector2(0, 10))

func update_animation_tree():
	$WalkingParticles.emitting = false
	if(just_jumped):
		state_machine.travel("JumpStart")
	elif was_on_floor && is_on_floor():
		if abs(velocity.x) > 5 || movement_direction != Vector2.ZERO:
			if $GroundParticlesRay.is_colliding():
				$WalkingParticles.emitting = true
			state_machine.travel("Walking")
		else:
			state_machine.travel("Idle")
	elif !was_on_floor && is_on_floor():
		state_machine.travel("JumpLand")
		spawn_jump_land_particles()
		extra_jumps = max_extra_jumps
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
	emit_signal("pick_up_key")
	print("pickup key")

func high_jump():
	velocity.y = -jump_speed * 1.3
	just_jumped = true

func damage_control():
	emit_signal("death")

func _on_CanMoveTimer_timeout():
	can_move = true
