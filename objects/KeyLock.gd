extends Area2D

signal keylock_opened
var opened = false

func _on_KeyLock_body_entered(body):
	if body.is_in_group("Player") and body.has_key() and not opened:
		opened = true
		emit_signal("keylock_opened")
