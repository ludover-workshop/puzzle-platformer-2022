extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		Global.checkpoint_position = body.position
		$AnimatedSprite.animation = "disabled"
		$CollisionShape2D.queue_free()
		$AudioStreamPlayer.play()
