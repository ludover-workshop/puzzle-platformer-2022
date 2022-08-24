extends StaticBody2D

export(String, "up", "down", "left", "right") var orientation = "up"
export(bool) var is_on = false
export(int, 1, 10) var beam_length = 1
export(NodePath) var switch_path
export(String) var switch_signal_on = "switched_on"
export(String) var switch_signal_off = "switched_off"

const BeamScene = preload("res://objects/ColorBeam.tscn")

var beam_color
var switch_node
var beams = []

# Called when the node enters the scene tree for the first time.
func _ready():

	switch_node = get_node(switch_path)
	switch_node.connect(switch_signal_on, self, "toggle")
	switch_node.connect(switch_signal_off, self, "toggle")

	$CannonSprite.animation = orientation
	
	var beam_position
	var beam_direction
	var beam_rotation = 0

	match orientation:
		"up":
			beam_position = Vector2(0, -21)
			beam_direction = Vector2(0, -21)
			beam_rotation = 90
		"down":
			beam_position = Vector2(0, 21)
			beam_direction = Vector2(0, 21)
			beam_rotation = 90
		"left":
			beam_position = Vector2(-21, 0)
			beam_direction = Vector2(-21, 0)
		"right":
			beam_position = Vector2(21, 0)
			beam_direction = Vector2(21, 0)

	for i in range(beam_length):
		var beam = BeamScene.instance()
		beams.append(beam)
		add_child(beam)
		beam.position = beam_position + i * beam_direction
		beam.rotation_degrees = beam_rotation
		beam.set_color(switch_node.color)
		
	is_on = not is_on
	toggle()

func toggle():
	for beam in beams:
		if is_on:
			beam.disable()
		else:
			beam.enable()
	is_on = not is_on

