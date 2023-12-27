extends Node3D


# Called when the node enters the scene tree for the first time.
func _init():
	Game.reset_game()
	
func _ready():
	%techo.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var luces = Game.Luz
	
	$pizzeria/iluminacion.visible = luces
	$pizzeria/oficina/sala_iluminacion.visible = luces
	$pizzeria/oficina/luz_emergencia.visible = !luces
	
	if Game.Energy < 10:
		Game.Luz = false
	pass
