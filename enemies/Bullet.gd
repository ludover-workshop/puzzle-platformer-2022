extends Area2D

var speed = 100

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("Player"):
		body.damage_control()
	queue_free()
