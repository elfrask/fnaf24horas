extends Node3D

enum MODELS_AI {
	ALFREDO,
	BONNIEFACIO,
	CHICA,
	FURRY
}

var  MODELS = ["FREDDY", "BONNIE", "CHICA", "FOXY"]

@export var PointInit: String = "FREDDY"
@export var IAModel: MODELS_AI = MODELS_AI.ALFREDO

var MODEL = {}
var this_point: String = PointInit
var CustomPoint = ""

var linealPosition = 0
var disable = false
var closed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	loadAI(MODELS[IAModel])
	$base.visible = false
	$dir.visible = false
	pass # Replace with function body.

func loadAI(model: String):
	MODEL = Modelsai.MODEL.get(model, {})
	PointInit = MODEL.get("init", PointInit)
	linealPosition = MODEL["POINTS"].find(PointInit)
	$delay.wait_time = MODEL.get("delay", 5.0)
	$delay.start()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !disable:
		var point = MODEL["POINTS"][linealPosition]
		var current_point = Game.get_point(point)
		
		if current_point is bool:
			print(point)
		global_position = current_point.global_position
		global_rotation = current_point.global_rotation
	else:
		
		var current_point = Game.get_point(CustomPoint)
		
		if current_point is bool:
			print(CustomPoint)
		global_position = current_point.global_position
		global_rotation = current_point.global_rotation
	pass

func jumpscare():
	var player = Game.get_obj("player")
	player.jumpscare()
	$delay.stop()
	CustomPoint = "jumpscare"
	disable = true
	$jumpscare.play(0.32)
	
	pass

func tick():
	var function = MODEL["onmove"]
	function.call(MODEL, self)
	pass


func _on_delay_timeout():
	
	$delay.stop()
	tick()
	if !disable:
		$delay.start()
	pass # Replace with function body.


func _on_jumpscare_finished():
	get_tree().change_scene_to_file("res://nodes/lose.tscn")
	pass # Replace with function body.
