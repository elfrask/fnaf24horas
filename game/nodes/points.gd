extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	Game.set_point(self.name, self)
	$base.visible = false
	$dir.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
