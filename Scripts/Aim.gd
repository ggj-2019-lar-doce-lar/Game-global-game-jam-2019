extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
var aim_enabled = true

var can_shoot = true
onready var sprite = $AimSprite
onready var timer = $Timer
var damage = 0

export(float) var timer_delay = 0.5
# Declare member variables here. Examples:
# var a = 2
func set_fire_rate(fire_rate):
	print($AnimationPlayer.playback_speed)
	$AnimationPlayer.playback_speed = fire_rate
	print($AnimationPlayer.playback_speed)
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Idle")
	pass # Replace with function body.

func _process(delta):
	sprite.position = get_global_mouse_position() - global_position
	if aim_enabled == false:
		sprite.hide()
	elif Input.is_action_pressed("mouse_click") and can_shoot:
		if $AnimationPlayer.current_animation == "Idle":
			$AnimationPlayer.play("Shoot")
		pass
	pass
	
func shoot():
	var new_bullet = bullet.instance()
	new_bullet.direction = sprite.position.normalized()
	get_parent().add_child(new_bullet)
	new_bullet.position = position
	new_bullet.damage = damage
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
