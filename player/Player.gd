extends KinematicBody2D

var speed = 60

var moving = false

func _ready():
	print("Hola Mundo")

func _physics_process(delta):
	var movement_direction = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_RIGHT):
		movement_direction = Vector2.RIGHT
	if Input.is_key_pressed(KEY_LEFT):
		movement_direction = Vector2.LEFT
		
	move_and_slide(movement_direction * speed)
