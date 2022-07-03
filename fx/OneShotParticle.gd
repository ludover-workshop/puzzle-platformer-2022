extends Particles2D

func _ready():
	one_shot = true
	emitting = true

func process():
	if !emitting:
		queue_free()
