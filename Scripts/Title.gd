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
	if $Continue.connect("pressed",self,"_on_continue") != 0:
		print("Error: Failed connecting_signal")
	pass

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
func _on_continue():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	save_game.open("user://savegame.save", File.READ)
	var content = save_game.get_as_text()
	save_game.close()
	var save = JSON.parse(content)
	if (save.result):
		player.hp = save.result.hp
		player.points = save.result.points
		player.damage = save.result.damage
		player.shot_cooldown = save.result.shot_cooldown
		player.last_level = save.result.last_level
		player.upgrades = save.result.upgrades
	else:
		print("deu ruim")
		return
	return
