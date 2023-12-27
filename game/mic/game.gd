extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 45
	print(Engine.max_fps)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var points = {}
var points_list = []
var Luz = true
var Energy = 1000
var time: float = 0
var usage = []
var Objs = {}

func get_usage():
	
	return 1 + len(usage)

func add_usage(nombre: String):
	if usage.count(nombre) == 0:
		usage.append(nombre)
	pass

func remove_usage(nombre: String):
	if usage.count(nombre) != 0:
		usage.erase(nombre)
		pass

func set_point(nombre: String, point: Node3D):
	points[nombre] = point
	points_list.append(nombre)
	print("Added point: ", nombre)
	pass
	
func get_point(nombre: String):
	
	return points.get(nombre, false)

func set_obj(nombre: String, point: Node3D):
	Objs[nombre] = point
	print("Added Object global eviroment: ", nombre)
	pass
	
func get_obj(nombre: String):
	
	return Objs.get(nombre, false)

func reset_game():
	points = {}
	points_list = []
	Luz = true
	Energy = 1000
	time = 0
	
