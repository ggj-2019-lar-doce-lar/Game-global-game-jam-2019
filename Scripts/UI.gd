extends Control

func _ready():
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
