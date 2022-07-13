extends Node2D

func _ready():
	randomize()
	if Global.checkpoint_position:
		$Player.position = Global.checkpoint_position
