extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _enemy_entered_area(body):
	if body.is_in_group("Enemy"):
		print("Enemy_entered")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	if $DefenseArea.connect("body_entered",self,"_enemy_entered_area") != 0:
		print("Failed to connect signal")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
