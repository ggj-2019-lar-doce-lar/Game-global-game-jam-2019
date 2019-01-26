extends Node2D


signal level_end(win)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inimigos
var timer = 0
export(int) var HP = 500

func set_paused(val):
	set_process(not val)
	for child in get_children():
		if child.has_method("set_paused"):
			child.set_paused(val)


const enemy_spawn = [Vector2(1100, 290),Vector2(1100, 500)]
func get_random_enemy_position():
	return enemy_spawn[0] + randf()*(enemy_spawn[1] - enemy_spawn[0])
	pass

func change_level(level):
	pass

var pause_status = false
var toggle
func _input(event):
	if event.is_action("pause_action") and event.is_action_pressed("pause_action"):
		pause_status = not pause_status
		set_paused(pause_status)
		pass
	pass

func game_over():
	get_tree().change_scene_to(global.title_scene)

func _enemy_entered_area(body):
	if body.is_in_group("Enemy"):
		print("Enemy_entered")
		body.attack(self)

func get_hit(damage):
	HP -= damage
	if HP <= 0:
		game_over()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$UI.set_max_life(HP)
	$UI.set_max_cooldown($Aim.get_bullet_cooldown())
	if $DefenseArea.connect("body_entered",self,"_enemy_entered_area") != 0:
		print("Failed to connect signal")
	pass
	inimigos = global.get_level_stuff()
	print(inimigos)
	for enemy in inimigos:
		enemy.tempos.sort()
	print(inimigos)
	
func _process(delta):
	timer += delta
	var num_enemies = global.enemy_list.size()
	var acabou = true
	for enemy in inimigos:
		if enemy.id < num_enemies:
			acabou = false
			if enemy.tempos.size() > 0:
				if enemy.tempos[0] <= timer:
					enemy.tempos.remove(0)
					var new_enemy = global.enemy_list[enemy.id].instance()
					add_child(new_enemy)
					new_enemy.position = get_random_enemy_position()
				pass
		pass
	$UI.set_life(HP)
	$UI.set_cooldown($Aim.get_current_timer())
#	pass
