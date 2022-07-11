extends StaticBody2D

func set_color(color):
	$AnimatedSprite.animation = color
	
func disable():
	$CollisionShape2D.disabled = true
	visible = false
	
func enable():
	$CollisionShape2D.disabled = false
	visible = true
