extends KinematicBody2D
class_name Enemy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var HP = 10
export(int) var ATK = 500
export(int) var SPEED = 100
export(float) var ATTACK_DELAY = 1.0
export(int) var POINTS = 100

var player
var timer

signal died()


onready var life_bar = $LifeBar
var vel_vec = Vector2(-1, 0)

var attacking_barrier = false

func attack(obj, barrier = false):
	if vivo:
		if barrier:
			attacking_barrier = true
		else:
			barrier_is_down = false
		player = obj
		vel_vec = Vector2(0,0)
		if timer.has_method("start"):
			timer.start()
		elif timer.has_method("play"):
			timer.play("Attack")
		pass

func _timeout_attack():
	if vivo:
		if not barrier_is_down:
			player.get_hit(ATK, attacking_barrier)
			for child in get_children():
				if child.name == "SSSofa":
					get_node("SSSofa").play()

var barrier_is_down = false
func barrier_down():
	if vivo:
		barrier_is_down = true
		attacking_barrier = false
		if not timer.has_method("play"):
			timer.stop()
	pass

func on_animation_ended(anim):
	if vivo:
		if not barrier_is_down and anim == "Attack":
			$AnimationPlayer.play("Attack")
		if anim == "Attack" and barrier_is_down:
			print("Barrier Down")
			barrier_is_down = false
			vel_vec = Vector2(-1, 0)
			$AnimationPlayer.play("Idle")
		elif anim != "Attack":
			barrier_is_down = false

var vivo = true
func take_damage(damage):
	HP -= damage
	life_bar.value = HP
	if HP <= 0 and vivo:
		vivo = false
		emit_signal("died")
		set_process(false)
		$CollisionShape2D.disabled=true
		$AnimationPlayer.play("Fade_out")
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	var has_animation = false
	for child in get_children():
		if child.name == "AnimationPlayer":
			has_animation = true
			
	if not has_animation:
		timer = Timer.new()
		timer.wait_time = ATTACK_DELAY
		add_child(timer)
		timer.connect("timeout",self,"_timeout_attack")
	else:
		$AnimationPlayer.play("Idle")
		$AnimationPlayer.connect("animation_finished",self,"on_animation_ended")
		timer = $AnimationPlayer
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
