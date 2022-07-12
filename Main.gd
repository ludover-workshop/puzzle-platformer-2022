extends Node2D

func _ready():
	randomize()
	if Global.checkpoint:
		$Player.position = Global.checkpoint

