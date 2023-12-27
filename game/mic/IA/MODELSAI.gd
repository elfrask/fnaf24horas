extends Node


func onmove(modelo: Dictionary, instancia):
	if !Game.Luz:
		instancia.linealPosition = 0
		return 0
	var PUNTOS = modelo["POINTS"]
	var maxlong = len(PUNTOS)
	
	var a = (randi() % 7) -1
	
	if a > 1: 
		a = 1
	
	var lp = instancia.linealPosition
	
	if lp < maxlong:
		lp += a
		pass
	if lp < 0:
		lp = 0
	
	
	if instancia.closed:
		lp = randi() % 3
		#lp = 0
	
	if lp == maxlong:
		instancia.jumpscare()
		
	instancia.linealPosition = lp
	
	pass



func onmove_freddy(modelo: Dictionary, instancia):
	
	if false:
		return 0
	#print_debug("Freddy se movio ", Game.Luz)
	var PUNTOS = modelo["POINTS"]
	var maxlong = len(PUNTOS)
	
	
	var lp = instancia.linealPosition
	# reconfigurado
	# lp += 1
	lp += 0
	
	instancia.linealPosition = lp
	pass


var MODEL = {
	"FREDDY":{
		"POINTS":["FREDDY", "FREDDY", "FREDDY", "CHICA8",  "CHICA8"],
		"delay": 10,
		"onmove": onmove_freddy,
		#"init":"jumpscare"
		
	},
	"BONNIE":{
		"POINTS":["BONNIE", "BONNIE2", "BONNIE3", "BONNIE4", "BONNIE5", "BONNIE6", "BONNIE7", "BONNIE7" ],
		"onmove": onmove,
		"delay": 7,
	},
	"CHICA":{
		"POINTS":["CHICA", "CHICA2", "CHICA3", "CHICA4", "CHICA5", "CHICA6", "CHICA7", "CHICA8", "CHICA8" ],
		"onmove": onmove,
		"delay": 5,
		
	},
	"FOXY":{
		"POINTS":["FOXY", "FOXY", "FOXY", "FOXY", "FOXY", "FOXY", "FOXY2", "FOXY3", "FOXY3"],
		"delay": 9,
		"onmove": onmove,
		
		
	},
	
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
