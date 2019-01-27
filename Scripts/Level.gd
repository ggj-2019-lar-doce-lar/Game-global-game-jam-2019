extends Node2D


signal level_end(win)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var temp_points = 0
var inimigos
var timer = 0
var max_hp
var HP

var barrier_max_hp
var barrier_hp

var current_enemy_list = []

const enemy_spawn = [Vector2(1100, 230),Vector2(1100, 530)]
func get_random_enemy_position():
	return enemy_spawn[0] + randf()*(enemy_spawn[1] - enemy_spawn[0])
	pass

func change_level(level):
	pass

var pause_status = false
var toggle

func _enemy_entered_defense_area(body):
	if body.is_in_group("Enemy"):
		body.attack(self, false)

func _enemy_entered_barrier(body):
	if body.is_in_group("Enemy"):
		body.attack(self, true)

var caiu_1 = false
var caiu_2 = false
var caiu_3 = false
var barrier_caiu_1 = false
var barrier_caiu_2 = false
var barrier_caiu_3 = false
onready var anim_player = $DefenseArea/AnimationPlayer
onready var barrier_anim_player = $Barrier/AnimationPlayer
func get_hit(damage, barrier = false):
	if not barrier:
		HP -= damage
		var fraction = float(HP)/float(max_hp)
		if fraction <= 0.7 and not caiu_1:
			caiu_1 = true
			anim_player.play("Cai_1")
		if fraction <= 0.4 and not caiu_2:
			caiu_2 = true
			anim_player.queue("Cai_2")
		if HP <= 0 and not caiu_3:
			caiu_3 = true
			anim_player.queue("Cai_3")
			$UI.set_life(0)
		pass
	else:
		barrier_hp -= damage
		var fraction = float(barrier_hp)/float(barrier_max_hp)
		if fraction <= 0.7 and not barrier_caiu_1:
			barrier_caiu_1 = true
			barrier_anim_player.play("Cai_1")
		if fraction <= 0.4 and not barrier_caiu_2:
			barrier_caiu_2 = true
			barrier_anim_player.queue("Cai_2")
		if barrier_hp <= 0 and not barrier_caiu_3:
			barrier_caiu_3 = true
			barrier_anim_player.queue("Cai_3")
			#Barrier_down
			$Barrier.queue_free()
			for enemy in current_enemy_list:
				enemy.barrier_down()
		pass
		pass
func winner():
	print("ganhei")
	$UI.winner()

func game_over(is_continue = false):
	$Aim.can_shoot = false
	if is_continue:
		$UI/ButtonDeathRestart.text = "Start"
		$UI/LifeBar.hide()
		$UI/LblScore.hide()
	$UI.game_over()
# Called when the node enters the scene tree for the first time.
func _ready():
	if global.is_continue:
		global.is_continue = false
		game_over(true)
	randomize()
	
	print("Points: " + str(player.points))
	print("Total Points: " + str(player.total_points))
	print("Last level: " + str(player.last_level))
	print("Current level: " + str(player.current_level))
	print("Upgrades: " + str(player.upgrades))
	
	max_hp = global.upgrade_chart.hp[player.upgrades.hp].value
	HP = max_hp
	var shot_damage = global.upgrade_chart.damage[player.upgrades.damage].value
	$Aim.damage = shot_damage
	var fire_rate = global.upgrade_chart.firerate[player.upgrades.firerate].value
	$Aim.set_fire_rate(fire_rate)
	print(fire_rate)
	
	barrier_max_hp = global.upgrade_chart.barrier[player.upgrades.barrier].value
	if barrier_max_hp == 0:
		$Barrier.monitorable = false
		$Barrier.monitoring = false
		$Barrier.hide()
	else:
		barrier_hp = barrier_max_hp
		$Barrier.connect("body_entered",self,"_enemy_entered_barrier")
	$WinTimer.connect("timeout",self,"winner")
	
	$UI.set_max_life(HP)
	
	if $DefenseArea.connect("body_entered",self,"_enemy_entered_defense_area") != 0:
		print("Failed to connect signal")
	pass
	
	inimigos = global.get_level_stuff()
	if inimigos == null:
		player.current_level = 0
		get_tree().change_scene_to(global.title_scene)
	else:
		for enemy in inimigos:
			enemy.tempos.sort()
	
	

func _enemy_died(enemy):
	
	#Bote algo aqui
	temp_points += enemy.POINTS
	current_enemy_list.erase(enemy)
	#enemy.queue_free()
	pass

var won = false
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
	if acabou and current_enemy_list.size() == 0 and not won:
		$Aim.can_shoot = false
		#Ganhou aqui
		won = true
		$WinTimer.start()
		
		pass
	$UI.set_life(HP)
	$UI.set_points(temp_points)
#	pass
