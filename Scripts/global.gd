extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const upgrade_chart = {
						"hp":[{"price":0, "value":500},
							  {"price":2000, "value": 1000},
							  {"price":5000, "value": 2000}],
						"damage":[{"price":0, "value":50},
							  {"price":2000, "value": 100},
							  {"price":5000, "value": 200}],
						"firerate":[{"price":0, "value":1.25},
							  {"price":4000, "value": 1.5},
							  {"price":10000, "value": 2.0}],
						"turret":[{"price":0, "value":0},
						      {"price":2000, "value":50},
							  {"price":5000, "value":100},
							  {"price":10000, "value":200}],
						"barrier":[{"price":0, "value":0},
						      {"price":2000, "value":500},
							  {"price":5000, "value": 1000},
							  {"price":10000, "value": 2000}]
						}

const level_list = [
					"res://Scenes/Levels/level_0.json",
					"res://Scenes/Levels/level_1.json",
					"res://Scenes/Levels/level_2.json",
					"res://Scenes/Levels/level_3.json",
					"res://Scenes/Levels/level_4.json",
					"res://Scenes/Levels/level_5.json"
					]

var enemy_list = [preload("res://Scenes/Enemies/Enemy0.tscn"),
					preload("res://Scenes/Enemies/Enemy1.tscn"),
					preload("res://Scenes/Enemies/Enemy2.tscn")]
					
var title_scene = preload("res://Scenes/Title.tscn")
var level_scene = preload("res://Scenes/Level_test.tscn")
var choose_scene = preload("res://Scenes/ChooseLevel.tscn")

var is_continue = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pas


func get_level_stuff():
	
	return retorna_fase(level_list[player.current_level])

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
		"points" : player.points,
		"last_level" : player.last_level,
		"upgrades" : player.upgrades,
		"total_points" : player.total_points
	}
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.WRITE)
	else:
		save_game.open("user://savegame.save", File.READ_WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	return