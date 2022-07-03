extends Particles2D

func _ready():
	emitting = true

func process():
	if !emitting:
		queue_free()
