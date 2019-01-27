extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	if $Start.connect("pressed",self,"_on_new_game") != 0:
		print("Error: Failed connecting signal")
	if $Quit.connect("pressed",self,"_on_quit") != 0:
		print("Error: Failed connecting_signal")
	pass # Replace with function body.

func _on_new_game():
	player.current_level = 0
	if get_tree().change_scene_to(global.level_scene) != 0:
		print("Error: Failed to start Scene")
		pass
	pass

func _on_quit():
	get_tree().quit()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
