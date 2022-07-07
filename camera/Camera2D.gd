extends Camera2D

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	position = player.position

var duration = 0.5
var strength = 15
var frequency = 5

var remainingShakeDuration = 0

var phase = Vector2.ZERO
var initial_offset: Vector2 = offset

func _ready():
	initial_offset = offset

func shake(strength = 10, duration = 0.7, frequency = 10):
	phase = Vector2(rand_range(0, TAU), rand_range(0, TAU))
	self.strength = strength
	self.duration = duration
	self.frequency = frequency
	
	remainingShakeDuration = duration
	
func _physics_process(delta):
	if remainingShakeDuration > 0:
		var elapsed = duration - remainingShakeDuration
		
		offset.x = initial_offset.x + strength * sin(elapsed * TAU * frequency + phase.x) * (remainingShakeDuration * remainingShakeDuration) / duration
		offset.y = initial_offset.y + strength * sin(elapsed * TAU * frequency + phase.y) * (remainingShakeDuration * remainingShakeDuration) / duration
		
		remainingShakeDuration -= delta
	else:
		offset = initial_offset
