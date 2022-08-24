extends Area2D

export(String, "yellow", "red", "green", "blue") var color = "red"
export(bool) var is_on = false

signal switched_on
signal switched_off

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = color
	
	if is_on:
		switch_on(false)
	else:
		switch_off(false)

func interact():
	$AudioStreamPlayer.play()
	if is_on:
		switch_off()
	else:
		switch_on()

func switch_on(emit=true):
	$AnimatedSprite.frame = 1
	if emit:
		emit_signal("switched_on")
	is_on = true
	
func switch_off(emit=true):
	$AnimatedSprite.frame = 0
	if emit:
		emit_signal("switched_off")
	is_on = false
