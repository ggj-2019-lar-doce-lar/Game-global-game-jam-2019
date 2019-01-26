extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var title = preload("res://Scenes/Title.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
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
	
	