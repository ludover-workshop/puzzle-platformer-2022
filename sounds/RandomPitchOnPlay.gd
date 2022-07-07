extends AudioStreamPlayer

func _set_playing(value):
	pitch_scale = rand_range(0.5, 1.5)
	.set_playing(value)
