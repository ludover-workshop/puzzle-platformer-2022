extends StaticBody2D

func _ready():
	$AnimationPlayerGlow.play("glow")

func set_color(color):
	$AnimatedSprite.animation = color
	
func disable():
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("disable")
	#visible = false
	
func enable():
	$CollisionShape2D.disabled = false
	$AnimationPlayer.play("enable")
	#visible = true
