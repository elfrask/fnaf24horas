extends Control


@export var NodeSet: NodePath
@export var Property: String
@export var NumberCAM: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$c2.text = NumberCAM
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_boton_pressed():
	$camara.play()
	get_node(NodeSet).set_cam(Property)
	pass # Replace with function body.
