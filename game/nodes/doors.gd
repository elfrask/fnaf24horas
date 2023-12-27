extends Area3D

@export var doorID = ""
var close = false
var animatronicos = []

func alternar():
	if Game.Luz:
		$doors.play(0.41)
		if close:
			$ani.play("open")
			Game.remove_usage(doorID)
		else:
			$ani.play("close")
			Game.add_usage(doorID)
			
		close = !close
		for i in animatronicos:
			i.get_parent().closed = true
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.set_obj(doorID, self)
	pass # Replace with function body.

func out_of_energy():
	if close:
		$ani.play("open")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Game.Luz and close:
		close = false
		$ani.play("open")
		
		pass
	
	pass


func _on_body_entered(body):
	
	if body is CharacterBody3D:
		if body.is_in_group("IA"):
			if close:
				body.get_parent().closed = true
			animatronicos.append(body)
			print("animatronico!")
			pass
	pass # Replace with function body.


func _on_body_exited(body):
	if body is CharacterBody3D:
		if body.is_in_group("IA"):
			animatronicos.erase(body)
			body.get_parent().closed = false
			pass
	pass # Replace with function body.
