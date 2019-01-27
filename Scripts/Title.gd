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
	player.last_level = 0
	player.points = 0
	player.total_points = 0
	player.current_level = 0
	player.upgrades = {
		"hp" : 0,
		"damage" : 0,
		"firerate" : 0,
		"turret" : 0,
		"barrier" : 0
	}
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
	print("entrou")
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	save_game.open("user://savegame.save", File.READ)
	var content = save_game.get_as_text()
	save_game.close()
	var save = JSON.parse(content)
	if (save.result):
		player.points = save.result.points
		player.last_level = save.result.last_level
		player.upgrades = save.result.upgrades
		player.total_points = save.result.total_points
		
	else:
		print("deu ruim")
		return
	
	var escolhe = global.choose_scene.instance()
	add_child(escolhe)
	return
	
func ajeita():
	$Continue.disabled = false
	$Start.disabled = false
	$Quit.disabled = false
	pass
