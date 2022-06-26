extends Area2D

signal keylock_opened

func _on_KeyLock_body_entered(body):
	if body.is_in_group("Player") and body.has_key():
		emit_signal("keylock_opened")
