extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var HP = 500

func game_over():
	get_tree().change_scene_to(global.title)

func _enemy_entered_area(body):
	if body.is_in_group("Enemy"):
		print("Enemy_entered")
		HP -= body.ATK
		if HP <= 0:
			game_over()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI.set_max_life(HP)
	$UI.set_max_cooldown($Aim.get_bullet_cooldown())
	if $DefenseArea.connect("body_entered",self,"_enemy_entered_area") != 0:
		print("Failed to connect signal")
	pass
	var inimigos = global.retorna_fase("res://Scenes/Levels/test.gd")
	for i in range(2):
		if (int(inimigos[i].id) == 0):
			var inimigo0 = inimigos[i].times
		elif(int(inimigos[i].id) == 1):
			var inimigo1 =
		pass
		 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI.set_life(HP)
	$UI.set_cooldown($Aim.get_current_timer())
#	pass
