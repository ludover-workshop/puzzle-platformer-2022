extends Node2D

var death = false

func _process(delta):
	if death && Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		get_tree().paused = false
		$WorldEnvironment.environment.adjustment_saturation = 1
		$CanvasLayer/GameOverContainer.visible = false

func _on_Player_death():
	get_tree().paused = true
	desaturate_world()
	show_game_over()
	$Tween.start()
	$DeathSound.play()
	
	death = true
	$Camera2D.shake()
	
func desaturate_world():
	$Tween.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", 1, 0, 1)
	
func show_game_over():
	$CanvasLayer/GameOverContainer.visible = true
	$Tween.interpolate_property($CanvasLayer/GameOverContainer, "modulate", Color(1,1,1,0), Color.white, 1)

func flash_white():
	$Tween.interpolate_property($WorldEnvironment.environment, "adjustment_brightness", 1, 5, 0.2)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property($WorldEnvironment.environment, "adjustment_brightness", 5, 1, 0.2)
	$Tween.start()
	
func _on_KeyLock_keylock_opened():
	$Camera2D.shake(5, 0.5, 10)
	flash_white()

