extends Area2D

const PickupFx = preload("res://fx/PickUpFX.tscn")

func _on_Coin_body_entered(body):
	if body.is_in_group("Player"):
		body.pickup_coin()
		var fx = Fx.spawn(PickupFx, self)
		fx.play_sound("Coin")
		queue_free()
		
