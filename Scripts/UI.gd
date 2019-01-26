extends Control

func _ready():
	pass
	
func game_quit():
	get_tree().paused = false
	get_tree().change_scene_to(global.title)	
		
func game_pause():
	if(get_tree().paused == true):
		get_tree().paused = false
	else:
		get_tree().paused = true
		
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
		
func _on_OptionButton_item_selected(ID, extra_arg_0):
	if(ID == 1):
		game_restart()	
	elif(ID == 2):
		game_quit()
	pass # Replace with function body.



func _on_OptionButton_pressed():
	game_pause()
	pass # Replace with function body.

