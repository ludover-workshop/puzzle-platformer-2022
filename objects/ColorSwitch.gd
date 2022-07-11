extends Area2D

export(String, "yellow", "red", "green", "blue") var color = "red"
export(bool) var is_on = false

signal switched_on
signal switched_off

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = color
	
	if is_on:
		switch_on()
	else:
		switch_off()

func interact():
	if is_on:
		switch_off()
	else:
		switch_on()

func switch_on():
	$AnimatedSprite.frame = 1
	emit_signal("switched_on")
	is_on = true
	
func switch_off():
	$AnimatedSprite.frame = 0
	emit_signal("switched_off")
	is_on = false
