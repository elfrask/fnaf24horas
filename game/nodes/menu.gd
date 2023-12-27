extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$chamba.play("RESET")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func to_game():
	get_tree().change_scene_to_file("res://nodes/PIZZERIA.tscn")


func _on_texture_button_pressed():
	$chamba.play("goit")
	pass # Replace with function body.
