extends Node3D


var started = false
@export var FreddyInstance: NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_nigthmare():
	started = true
	$sound.play()
	$delay_luz.start()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = !Game.Luz
	if !started and visible:
		start_nigthmare()
	pass


func _on_delay_luz_timeout():
	$luz.play("play")
	var jumpscare_delay = (4 + (randi() % 4)) * 3
	$delay_jumpscare.wait_time = jumpscare_delay
	print("jumpscare delay: ", jumpscare_delay)
	$delay_jumpscare.start()
	$delay_luz.stop()
	pass # Replace with function body.


func _on_delay_jumpscare_timeout():
	var instance = get_node(FreddyInstance)
	instance.jumpscare()
	queue_free()
	pass # Replace with function body.
