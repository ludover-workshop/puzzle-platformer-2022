extends Area2D


const PickupFx = preload("res://fx/PickUpFX.tscn")

func _on_DoubleJumpPowerUp_body_entered(body):
	if body.is_in_group("Player"):
		body.enable_double_jump()
		var fx = Fx.spawn(PickupFx, self)
		fx.play_sound("PowerUp")
		queue_free()
