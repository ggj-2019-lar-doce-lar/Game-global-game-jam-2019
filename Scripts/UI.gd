extends CanvasLayer

func _ready():
	pass
	
func game_quit():
	get_tree().paused = false
	get_tree().change_scene_to(global.title_scene)	
		
func game_pause():
	if(get_tree().paused == true):
		get_tree().paused = false
	else:
		get_tree().paused = true
	
func game_upgrades():
	pass
	
func game_restart():
	get_tree().paused = false
	get_tree().reload_current_scene()

func set_max_life(max_life):
	$LifeBar.max_value = max_life*100
	$LifeBar.value = max_life*100
	
func set_life(life):
	$LifeBar.value = life*100
	
func set_max_cooldown(max_cd):
	$ShotCooldown.max_value = max_cd*100
	$ShotCooldown.value = max_cd*100
	
func set_cooldown(cd):
	$ShotCooldown.value = cd*100

func game_over():
	
	get_tree().paused = true
	
	$OptionButton.disabled = true
	$OptionButton.hide()
	
	$ButtonDeathRestart.disabled = false
	$ButtonDeathRestart.show()
	$ButtonDeathUpgrades.disabled = false
	$ButtonDeathUpgrades.show()
	$ButtonDeathQuit.disabled = false
	$ButtonDeathQuit.show()
	pass
		
func _on_OptionButton_item_selected(ID, extra_arg_0):
	if(ID == 1):
		game_restart()	
	elif(ID == 2):
		game_quit()
	pass # Replace with function body.


func _on_OptionButton_pressed():
	game_pause()
	pass # Replace with function body.

func _on_ButtonDeathRestart_pressed():
	game_restart()
	pass # Replace with function body.

func _on_ButtonDeathUpgrades_pressed():
	game_upgrades()
	pass # Replace with function body.

func _on_ButtonDeathQuit_pressed():
	game_quit()
	pass # Replace with function body.
