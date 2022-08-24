extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

export(float) var max_move_speed: float = 30
export(float) var move_acceleration: float = 400
export(float) var gravity: float = 400
export(bool) var walk: bool = true
export(float) var autoturn: float = 0
export (PackedScene) var Bullet

var rng = RandomNumberGenerator.new()

var can_shoot = true
var movement_direction = Vector2.RIGHT

func _ready():
	rng.randomize()
	if walk:
		scale.x = 1
	else:
		$Sprite.animation = "shooting"
		movement_direction = Vector2.ZERO
		$FloorRay.enabled = false
		$WalkRay.enabled = false
	if autoturn > 0:
		$TurnTimer.wait_time = autoturn
		$TurnTimer.start()

func _physics_process(delta):
	if $WalkRay.is_colliding():
		var collider = $WalkRay.get_collider()
		if not collider.is_in_group("Player"):
			movement_direction *= -1
			scale.x *= -1
			
	if $FloorRay.enabled and not $FloorRay.is_colliding():
		movement_direction *= -1
		scale.x *= -1
		
	if $AimRay.is_colliding():
		if can_shoot:
			shoot()
			can_shoot = false
			$ReloadTimer.wait_time = rng.randf_range(0.5, 1.5)
			$ReloadTimer.start()
			
		$Sprite.animation = "shooting"
		return

	if movement_direction != Vector2.ZERO:
		$Sprite.animation = "walking"
		$SpriteAnimationPlayer.play("walking")
		velocity.x = move_toward(velocity.x,  movement_direction.x * max_move_speed, move_acceleration * delta)
	
	velocity = velocity + Vector2.DOWN * gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.damage_control()
		
func shoot():
	$ShootSound.play()
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = $GunAim.global_transform
	$GunAnimationPlayer.play("shoot")
	if autoturn:
		$TurnTimer.stop()
		$TurnTimer.start()

func _on_ReloadTimer_timeout():
	can_shoot = true

func _on_TurnTimer_timeout():
	if not $AimRay.is_colliding():
		scale.x *= -1

