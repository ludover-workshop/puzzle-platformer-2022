extends Node2D

func _ready():
	randomize()
	if Globals.checkpoint:
		$Player.position = Globals.checkpoint

