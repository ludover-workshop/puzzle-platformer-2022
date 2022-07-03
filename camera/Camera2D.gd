extends Camera2D

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	position = player.position
