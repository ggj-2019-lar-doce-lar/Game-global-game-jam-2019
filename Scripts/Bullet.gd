extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $Timer
export(int) var speed = 500
var direction = Vector2(-1,0)
var damage = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"queue_free")
	connect("area_entered",self,"_enemy_entered")
	pass # Replace with function body.

func _process(delta):
	position+=direction*speed*delta
	pass
	
func _enemy_entered(area):
	if area.is_in_group("Enemy"):
		print("Found enemy")
		if area.get_parent().has_method("take_damage"):
			area.get_parent().take_damage(damage)
			queue_free()
			pass
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
