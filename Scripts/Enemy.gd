extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var HP = 10
export(int) var ATK = 10
export(int) var SPEED = 100

var vel_vec = Vector2(SPEED, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemy")
	pass # Replace with function body.

func _process(delta):
	move_and_slide(vel_vec)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
