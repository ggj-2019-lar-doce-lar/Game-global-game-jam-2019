extends Node2D


signal level_end(win)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inimigos
var timer = 0
export(int) var HP = 500


const enemy_spawn = [Vector2(1100, 290),Vector2(1100, 500)]
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

func get_hit(damage):
	HP -= damage
	if HP <= 0:
	  $UI.set_life(0)
	  $UI.game_over()
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
