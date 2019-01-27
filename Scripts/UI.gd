extends CanvasLayer

var points = 0

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
	
	"0 o player perdeu e 1 ele ganhou"
	var deathOrWin = 0
	if($ButtonDeathQuit.disabled == true):
		deathOrWin = 1
	
	$ButtonDeathQuit.disabled = true
	$ButtonDeathRestart.disabled = true
	$ButtonDeathUpgrades.disabled = true
	
	$ButtonWinNext.disabled = true
	$ButtonWinRestartCurrent.disabled = true
	$ButtonWinQuit.disabled = true
	$ButtonWinUpgrades.disabled = true
	
	$FUNDOMORTE.hide()
	
	$Upgrades/Label.text = "Current Points: " + str(points)
	
	$Upgrades.DeathOrWin = deathOrWin
	$Upgrades.visible = true
	$Upgrades/GridContainer/GunButton.disabled = false
	$Upgrades/GridContainer/FortButton.disabled = false
	$Upgrades/GridContainer/FRButton.disabled = false
	$Upgrades/GridContainer/TurretButton.disabled = false
	$Upgrades/GridContainer/BarrierButton.disabled = false
	
	$Upgrades/Refund.disabled = false
	$Upgrades/Return.disabled = false
	
	pass
	
func enable_death_buttons():
	$ButtonDeathQuit.disabled = false
	$ButtonDeathRestart.disabled = false
	$ButtonDeathUpgrades.disabled = false
	pass

func enable_win_buttons():
	$ButtonWinNext.disabled = false
	$ButtonWinRestartCurrent.disabled = false
	$ButtonWinQuit.disabled = false
	$ButtonWinUpgrades.disabled = false
	pass		
	
func game_restart():
	get_tree().paused = false
	get_tree().reload_current_scene()

func set_points(valor):
	$LblScore.text = "Score: "+str(valor)
	points = valor
	pass

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

func winner():
	var placeholder = 50
	player.points += points
	player.total_points += points
	if player.last_level == player.current_level:
		player.last_level += 1
		if player.last_level >= placeholder:
			pass
			#Zerou
	global.save()

	
	get_tree().paused = true
	$OptionButton.disabled = true
	$OptionButton.hide()
	
	$Label.show()
	$ButtonWinNext.disabled = false
	$ButtonWinNext.show()
	$ButtonWinRestartCurrent.disabled = false
	$ButtonWinRestartCurrent.show()
	$ButtonWinQuit.disabled = false
	$ButtonWinQuit.show()
	$ButtonWinUpgrades.disabled = false
	$ButtonWinUpgrades.show()

func game_over():
	
	get_tree().paused = true
	$FUNDOMORTE.show()
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

func _on_ButtonWinNext_pressed():
	player.current_level += 1
	game_restart()
	pass # Replace with function body.