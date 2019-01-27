extends Node2D


signal level_end(win)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var temp_points = 0
var inimigos
var timer = 0
export(int) var HP = 500

var current_enemy_list = []

const enemy_spawn = [Vector2(1100, 230),Vector2(1100, 530)]
func get_random_enemy_position():
	return enemy_spawn[0] + randf()*(enemy_spawn[1] - enemy_spawn[0])
	pass

func change_level(level):
	pass

var pause_status = false
var toggle

func _enemy_entered_area(body):
	if body.is_in_group("Enemy"):
		print("Enemy_entered")
		body.attack(self)

var max_hp_reference
var caiu_1 = false
var caiu_2 = false
var caiu_3 = false
onready var anim_player = $DefenseArea/AnimationPlayer
func get_hit(damage):
	HP -= damage
	var fraction = float(HP)/float(max_hp_reference)
	if fraction <= 0.67 and not caiu_1:
		caiu_1 = true
		anim_player.play("Cai_1")
	if fraction <= 0.33 and not caiu_2:
		caiu_2 = true
		anim_player.queue("Cai_2")
	if HP <= 0 and not caiu_3:
		caiu_3 = true
		anim_player.queue("Cai_3")
		$UI.set_life(0)
		$Aim.can_shoot = false
	pass
func game_over():
	
	$UI.game_over()
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
	if inimigos == null:
		player.current_level = 0
		get_tree().change_scene_to(global.title_scene)
	else:
		for enemy in inimigos:
			enemy.tempos.sort()
	print(inimigos)
	max_hp_reference = HP

func _enemy_died(enemy):
	current_enemy_list.erase(enemy)
	print(current_enemy_list.size())
	#Bote algo aqui
	temp_points += enemy.POINTS
	
	enemy.queue_free()
	pass

func _process(delta):
	timer += delta
	var num_enemies = global.enemy_list.size()
	var acabou = true
	for enemy in inimigos:
		if enemy.id < num_enemies:
			if enemy.tempos.size() > 0:
				acabou = false
				if enemy.tempos[0] <= timer:
					enemy.tempos.remove(0)
					var new_enemy = global.enemy_list[enemy.id].instance()
					current_enemy_list.append(new_enemy)
					new_enemy.connect("died",self,"_enemy_died",[new_enemy])
					add_child(new_enemy)
					new_enemy.position = get_random_enemy_position()
				pass
		pass
	if acabou and current_enemy_list.size() == 0:
		print("Ganhou")
		#Ganhou aqui
		$UI.winner()
		
		pass
	$UI.set_life(HP)
	$UI.set_cooldown($Aim.get_current_timer())
	$UI.set_points(temp_points)
#	pass
