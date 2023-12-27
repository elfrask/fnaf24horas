extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$ani.play("RESET")
	$ani.play("play")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func tomenu():
	get_tree().change_scene_to_file("res://nodes/menu.tscn")
