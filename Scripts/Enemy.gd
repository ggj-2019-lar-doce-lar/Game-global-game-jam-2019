extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var HP = 10
export(int) var ATK = 500
export(int) var SPEED = 100

onready var life_bar = $LifeBar
var vel_vec = Vector2(SPEED, 0)

func take_damage(damage):
	HP -= damage
	life_bar.value = HP
	if HP <= 0:
		queue_free()
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	life_bar.min_value = 0
	life_bar.max_value = HP
	life_bar.value = HP
	add_to_group("Enemy")
	pass # Replace with function body.

func _process(delta):
	move_and_slide(vel_vec)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
