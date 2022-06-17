extends Camera2D

export(NodePath) var player_path = @"../Player"

onready var player = get_node(player_path)

func _process(delta):
	position = player.position
