extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

export(float) var max_move: int = 80
export(float) var move_horizontal: bool = true
export(float) var move_speed: float = 0.2

var movement_direction = Vector2.LEFT
var total_move = 0
var can_move = true

func _ready():
	if move_horizontal:
		movement_direction = Vector2.LEFT
	else:
		movement_direction = Vector2.UP

func _physics_process(delta):
	if not can_move:
		return

	total_move += move_speed
	if total_move > max_move:
		movement_direction *= -1
		total_move = 0
		can_move = false
		$Timer.start()
	else:
		position += movement_direction * move_speed

func _on_Timer_timeout():
	can_move = true
