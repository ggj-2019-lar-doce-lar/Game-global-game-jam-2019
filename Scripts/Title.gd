extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var next_scene = preload("res://Scenes/Title.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Start.connect("pressed",self,"_on_new_game")
	$Quit.connect("pressed",self,"_on_quit")
	pass # Replace with function body.

func _on_new_game():
	get_tree().change_scene_to(next_scene)
	pass

func _on_quit():
	get_tree().quit()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
