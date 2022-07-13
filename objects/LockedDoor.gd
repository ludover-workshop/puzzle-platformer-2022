extends Area2D

var opened = false

func open():
	opened = true
	$AnimatedSprite.animation = "opened"

func _on_LockedDoor_body_entered(body):
	if body.is_in_group("Player") and opened:
		print("Win!")
		Global.checkpoint_position = null
		get_tree().reload_current_scene()
