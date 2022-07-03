extends Area2D

const PickupFx = preload("res://fx/PickUpFX.tscn")

func _on_Key_body_entered(body):
	if body.is_in_group("Player"):
		body.pickup_key()
		Fx.spawn(PickupFx, self)
		queue_free()
