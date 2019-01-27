extends Panel

var DeathOrWin = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#button events for upgrade screen
func _on_GunButton_pressed():
	pass # Replace with function body.

func _on_FortButton_pressed():
	pass # Replace with function body.

func _on_FRButton_pressed():
	pass # Replace with function body.

func _on_TurretButton_pressed():
	pass # Replace with function body.

func _on_BarrierButton_pressed():
	pass # Replace with function body.

func _on_Refund_pressed():
	pass # Replace with function body.

func _on_Return_pressed():
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
