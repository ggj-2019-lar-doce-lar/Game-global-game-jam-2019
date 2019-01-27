extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func on_timeout():
	get_tree().change_scene_to(global.title_scene)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout",self,"on_timeout")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
