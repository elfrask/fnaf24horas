extends Node3D

@export var Puerta: NodePath
@export var Bombilla: NodePath

var StateDoor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Game.Luz:
		$luz2.stop()
	pass


func _on_luz_area_body_entered(body):
	if !Game.Luz:
		return
	if body is CharacterBody3D:
		if body.is_in_group("cursor"):
			print("Luz")
			$luz2.play(0)
			get_node(Bombilla).visible = true
			body.done()
			Game.add_usage(self.name + "-luz")
			$delay.start()
			pass
	pass # Replace with function body.


func _on_delay_timeout():
	get_node(Bombilla).visible = false
	Game.remove_usage(self.name + "-luz")
	$luz2.stop()
	
	pass # Replace with function body.


func _on_puerta_area_body_entered(body):
	if !Game.Luz:
		return
	if body is CharacterBody3D:
		if body.is_in_group("cursor"):
			var door:Node3D = get_node(Puerta)
			print("puerta")
			body.done()
			
			
			door.alternar()
			pass
	pass # Replace with function body.
