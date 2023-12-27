extends Camera3D

enum view {
	mid, L, R
}

enum MODES {
	doors,
	camaras,
	jumpscare
}

@export var range_view: float = 35.0
@export var speed = ease(0.0005, 0.01)
@export var CamareViewport: NodePath
@export var CountCamaras: int = 9

var CursorScene = preload("res://nodes/cursor_scene.tscn")

var StateView = view.mid
var ModeState = 0
var Relative = 90
var cursor = 0
var STATECAM = "CAM1"

# Called when the node enters the scene tree for the first time.
func _ready():
	Relative = rotation.y
	$usage.start()
	$camaras.play("RESET")
	$ani.play("play")
	$ambient.play()
	$call.play()
	Game.set_obj("player", self)
	
	pass # Replace with function body.

func _process(delta):
	if ModeState == MODES.doors:
		mode1(delta)
	elif ModeState == MODES.camaras:
		mode2(delta)
	var format = "12 PM"
	
	var hour = Game.time
	
	if hour > 99:
		format = str(int(hour/100)) + " AM"
	
	$Control/gui/usage.value = Game.get_usage()
	$Control/gui/energy.text = str(Game.Energy / 10) + "%"
	$Control/hour.text = format
	$Control/gui/Control/cam.text = STATECAM
	$Control/gui.visible = Game.Luz
	if !Game.Luz and (ModeState != MODES.doors):
		ModeState = MODES.doors
	if Game.time >= 600:
		get_tree().change_scene_to_file("res://nodes/win.tscn")
		pass
	pass

func is_in_cursor():
	if cursor is Node3D:
		cursor.queue_free()
		cursor = 0
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func mode1(delta):
	
	if StateView == view.L:
		rotation.y = lerp_angle((rotation.y), (Relative + deg_to_rad(range_view)), speed)
		pass
	if StateView == view.R:
		rotation.y = lerp_angle((rotation.y), (Relative - deg_to_rad(range_view)), speed)
	
	if Input.is_action_just_pressed("select"):
		var pre_cursor_pos  = _get_mouse()
		
		
		if ModeState != MODES.doors:
			return 0
		var cursor_pos = pre_cursor_pos
		#print_debug(cursor_pos)
		if cursor is Node3D:
			cursor.queue_free()
			cursor = 0
			pass
		if cursor_pos is Vector3:
			cursor = CursorScene.instantiate()
			add_child(cursor)
			cursor.set_position_custom(cursor_pos)
			cursor.function = is_in_cursor
		
	
	
	pass

func mode2(delta):
	var viewport: SubViewport = get_node(CamareViewport)
	
	$Control/gui/Control/content.texture = viewport.get_texture()
	pass

func _get_mouse():
	
	get_viewport()
	
	var ray_length = 1000
	var mouse = get_viewport().get_mouse_position()
	var worldspace = get_world_3d().direct_space_state
	var start = project_ray_origin(mouse)
	var end = start + project_ray_normal(mouse) * ray_length
	
	var ray = PhysicsRayQueryParameters3D.new()
	
	ray.from = start
	ray.to = end
	var result = worldspace.intersect_ray(ray)
	
	
	return result.get("position", false)

func mute():
	$call.stop()
	$Control/gui/mute.visible = false
	
	pass

func set_cam(prop: String):
	STATECAM = prop
	var cam: Camera3D = get_node(str(CamareViewport) + "/" + prop)
	
	for i in range(1, CountCamaras + 1):
		var came: Camera3D = get_node(str(CamareViewport) + "/CAM" + str(i))
		
		came.current = false
		pass
	
	cam.current = true
	pass

func _on_l_mouse_entered():
	StateView = view.L
	
	pass # Replace with function body.


func _on_r_mouse_entered():
	StateView = view.R
	
	pass # Replace with function body.

func switch_camare(die = false):
	if die:
		if ModeState == MODES.camaras:
			$camaras.play("close")
			Game.remove_usage("camaras")
			
		ModeState = MODES.jumpscare
		return 0
	if ModeState == MODES.doors:
		ModeState = MODES.camaras
		$camaras.play("open")
		Game.add_usage("camaras")
	elif ModeState == MODES.camaras:
		ModeState = MODES.doors
		$camaras.play("close")
		Game.remove_usage("camaras")
	
	
	pass

func jumpscare():
	
	switch_camare(true)
	
	pass

func _on_open_camaras_mouse_entered():
	$camara.play()
	switch_camare()
	pass # Replace with function body.


func _on_mute_pressed():
	mute()
	pass # Replace with function body.


func _on_usage_timeout():
	Game.time += 1.65
	Game.Energy -= Game.get_usage()
	pass # Replace with function body.


func _on_call_finished():
	mute()
	pass # Replace with function body.
