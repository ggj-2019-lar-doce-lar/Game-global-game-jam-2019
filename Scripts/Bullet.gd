extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $Timer
var speed = 300
var direction = Vector2(-1,0)
var damage = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"queue_free")
	connect("body_entered",self,"_enemy_entered")
	pass # Replace with function body.

func _process(delta):
	position+=direction*speed*delta
	pass
	
func _enemy_entered(body):
	if body.is_in_group("Enemy"):
		print("Found enemy")
		if body.has_method("take_damage"):
			body.take_damage(damage)
			queue_free()
			pass
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass