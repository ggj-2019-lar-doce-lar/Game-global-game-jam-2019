extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func scene_chosen(index):
	global.is_continue = true
	player.current_level = index
	get_tree().change_scene_to(global.level_scene)
	pass

func retorna():
	get_parent().ajeita()
	queue_free()
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/ReturnButton.connect("pressed",self,"retorna")
	var box_add = $Panel/ScrollContainer/VBoxContainer
	box_add.get_node("Button").connect("pressed",self,"scene_chosen",[0])
	print(player.last_level)
	for i in range(player.last_level+1):
		if i != 0:
			var new_button = Button.new()
			new_button.text = "Level "+str(i+1)
			new_button.connect("pressed",self,"scene_chosen",[i])
			box_add.add_child(new_button)
			pass
		pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
