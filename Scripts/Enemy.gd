extends KinematicBody2D
class_name Enemy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var HP = 10
export(int) var ATK = 500
export(int) var SPEED = 100
export(float) var ATTACK_DELAY = 1.0

var player

onready var life_bar = $LifeBar
var vel_vec = Vector2(-1, 0)

func attack(obj):
	player = obj
	vel_vec = Vector2(0,0)
	var timer = Timer.new()
	timer.wait_time = ATTACK_DELAY
	add_child(timer)
	timer.connect("timeout",self,"_timeout_attack")
	timer.start()
	pass

func _timeout_attack():
	player.get_hit(ATK)

func take_damage(damage):
	HP -= damage
	life_bar.value = HP
	if HP <= 0:
		queue_free()
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.add_to_group("Enemy")
	life_bar.min_value = 0
	life_bar.max_value = HP
	life_bar.value = HP
	add_to_group("Enemy")
	pass # Replace with function body.

func _process(delta):
	move_and_slide(vel_vec*SPEED)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
