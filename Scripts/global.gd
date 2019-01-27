extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy_list = [preload("res://Scenes/Enemies/Enemy0.tscn"),
					preload("res://Scenes/Enemies/Enemy1.tscn")]
					
var title_scene = preload("res://Scenes/Title.tscn")
var level_scene = preload("res://Scenes/Level_test.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pas


func get_level_stuff():
	
	return retorna_fase("res://Scenes/Levels/level_"+str(player.current_level)+".json")
	pass

func retorna_fase(caminho):
	var file = File.new()
	file.open(caminho, file.READ)
	var content = file.get_as_text()
	file.close()
	var lista = JSON.parse(content)
	if (lista.result):
		return lista.result
	else:
		print("Error: wrong JSON format, Screwed up loser")
		return null
	
func save():
	var save_dict = {
		"hp" : player.hp,
		"points" : player.points,
		"damage" : player.damage,
		"shot_cooldown" : player.shot_cooldown,
		"last_level" : player.last_level,
		"upgrades" : player.upgrades 
	}
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.WRITE)
	else:
		save_game.open("user://savegame.save", File.READ_WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	return