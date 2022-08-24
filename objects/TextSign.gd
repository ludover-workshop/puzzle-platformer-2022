extends Area2D

export(String) var message = "Hello world" 

func _ready():
	$LabelNode/Label.text = message

func _on_TextSign_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("show")


func _on_TextSign_body_exited(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("hide")
