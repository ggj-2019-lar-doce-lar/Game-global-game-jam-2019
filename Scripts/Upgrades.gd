extends Panel

var DeathOrWin = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_labels()
#	pass
func update_labels():
	$CurrentPoints.text = "Current Points: " + str(player.points)
	$TotalPoints.text = "Total Points: "+str(player.total_points)
	
	
	var dmg_level_display = player.upgrades.damage+1
	if dmg_level_display >= global.upgrade_chart.damage.size():
		$GridContainer/GunLevel.text = "Lv. MAX"
		$GridContainer/GunPrice.text = "$"
		$GridContainer/GunButton.disabled = true
	else:
		$GridContainer/GunLevel.text = "Lv. "+str(dmg_level_display)+"  "
		var price = global.upgrade_chart.damage[dmg_level_display].price
		$GridContainer/GunPrice.text = "$"+str(price)
		if player.points < price:
			$GridContainer/GunButton.disabled = true
		else:
			$GridContainer/GunButton.disabled = false
	
	
	var hp_level_display = player.upgrades.hp+1
	if hp_level_display >= global.upgrade_chart.hp.size():
		$GridContainer/FortLevel.text = "Lv. MAX"
		$GridContainer/FortPrice.text = "$"
		$GridContainer/FortButton.disabled = true
	else:
		$GridContainer/FortLevel.text = "Lv. "+str(hp_level_display)+"  "
		var price = global.upgrade_chart.hp[hp_level_display].price
		$GridContainer/FortPrice.text = "$"+str(price)
		if player.points < price:
			$GridContainer/FortButton.disabled = true
		else:
			$GridContainer/FortButton.disabled = false
	
	
	var fr_level_display = player.upgrades.firerate+1
	if fr_level_display >= global.upgrade_chart.firerate.size():
		$GridContainer/FRLevel.text = "Lv. MAX"
		$GridContainer/FRPrice.text = "$"
		$GridContainer/FRButton.disabled = true
	else:
		$GridContainer/FRLevel.text = "Lv. "+str(fr_level_display)+"  "
		var price = global.upgrade_chart.firerate[fr_level_display].price
		$GridContainer/FRPrice.text = "$"+str(price)
		if player.points < price:
			$GridContainer/FRButton.disabled = true
		else:
			$GridContainer/FRButton.disabled = false
	
	

	var barrier_level_display = player.upgrades.barrier
	if barrier_level_display == 0:
		$GridContainer/BarrierButton.text = "Buy Barrier"
	else:
		$GridContainer/BarrierButton.text = "Upgrade Barrier"
	if barrier_level_display >= global.upgrade_chart.barrier.size()-1:
		$GridContainer/BarrierNum.text = "Lv. MAX"
		$GridContainer/BarrierPrice.text = "$"
		$GridContainer/BarrierButton.disabled = true
	else:
		$GridContainer/BarrierNum.text = "Lv. "+str(barrier_level_display)+"  "
		var price = global.upgrade_chart.barrier[barrier_level_display+1].price
		$GridContainer/BarrierPrice.text = "$"+str(price)
		if player.points < price:
			$GridContainer/BarrierButton.disabled = true
		else:
			$GridContainer/BarrierButton.disabled = false
	
	if barrier_level_display == 0:
		$GridContainer/TurretButton.text = "Needs Barrier"
		$GridContainer/TurretButton.disabled = true
		pass
	else:
		var turret_level_display = player.upgrades.turret
		if turret_level_display == 0:
			$GridContainer/TurretButton.text = "Buy Turret"
		else:
			$GridContainer/TurretButton.text = "Upgrade Turret"
		if turret_level_display >= global.upgrade_chart.turret.size()-1:
			$GridContainer/TurretNum.text = "Lv. MAX"
			$GridContainer/TurretPrice.text = "$"
			$GridContainer/TurretButton.disabled = true
		else:
			$GridContainer/TurretNum.text = "Lv. "+str(turret_level_display)+"  "
			var price = global.upgrade_chart.turret[turret_level_display+1].price
			$GridContainer/TurretPrice.text = "$"+str(price)
			if player.points < price:
				$GridContainer/TurretButton.disabled = true
			else:
				$GridContainer/TurretButton.disabled = false
	
	
	
	pass

#button events for upgrade screen
func _on_GunButton_pressed():
	player.upgrades.damage += 1
	player.points -= global.upgrade_chart.damage[player.upgrades.damage].price
	
	pass # Replace with function body.

func _on_FortButton_pressed():
	player.upgrades.hp += 1
	player.points -= global.upgrade_chart.hp[player.upgrades.hp].price
	pass # Replace with function body.

func _on_FRButton_pressed():
	player.upgrades.firerate += 1
	player.points -= global.upgrade_chart.firerate[player.upgrades.firerate].price
	pass # Replace with function body.

func _on_TurretButton_pressed():
	player.upgrades.turret += 1
	player.points -= global.upgrade_chart.turret[player.upgrades.turret].price
	pass # Replace with function body.

func _on_BarrierButton_pressed():
	player.upgrades.barrier += 1
	player.points -= global.upgrade_chart.barrier[player.upgrades.barrier].price
	pass # Replace with function body.

func _on_Refund_pressed():
	player.upgrades.barrier = 0
	player.upgrades.turret = 0
	player.upgrades.damage = 0
	player.upgrades.hp = 0
	player.upgrades.firerate = 0
	player.points = player.total_points
	pass # Replace with function body.

func _on_Return_pressed():
	global.save()
	$GridContainer/GunButton.disabled = true
	$GridContainer/FortButton.disabled = true
	$GridContainer/FRButton.disabled = true
	$GridContainer/TurretButton.disabled = true
	$GridContainer/BarrierButton.disabled = true
	$Refund.disabled = true
	$Return.disabled = true
	hide()
	
	
	if(DeathOrWin == 0):
		get_parent().enable_death_buttons()
	else:
		get_parent().enable_win_buttons()
	
	pass # Replace with function body.
