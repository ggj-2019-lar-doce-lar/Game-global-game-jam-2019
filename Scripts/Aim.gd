extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
var aim_enabled = true

var can_shoot = true
onready var sprite = $AimSprite
onready var timer = $Timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _on_end_cooldown():
	can_shoot = true

func set_bullet_cooldown(time):
	timer.wait_time = time
	pass

func get_bullet_cooldown():
	return timer.wait_time
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_end_cooldown")
	pass # Replace with function body.

func _process(delta):
	sprite.position = get_global_mouse_position() - global_position
	if aim_enabled == false:
		sprite.hide()
	elif Input.is_action_pressed("mouse_click") and can_shoot:
		var new_bullet = bullet.instance()
		new_bullet.direction = sprite.position.normalized()
		get_parent().add_child(new_bullet)
		new_bullet.position = position
		can_shoot = false
		timer.start()
		pass
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
