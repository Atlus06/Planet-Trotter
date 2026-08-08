class_name Input_Component extends Node

var debug_mode: bool
var debug_Xdir: float
var debug_Ydir: float

var move_direction: float
var aim_direction: float
var jump_pressed := false
var dash_pressed := false
var crouch_pressed := false
var jump_released := false

var camera_look = Vector2.ZERO
var cam_zoom = false

func update() -> void:
	if debug_mode == false:
		#character movement
		move_direction = Input.get_axis("move_left", "move_right")
		aim_direction = Input.is_action_pressed("jump")
		jump_pressed = Input.is_action_just_pressed("jump")
		jump_released = Input.is_action_just_released("jump")
		dash_pressed = Input.is_action_just_pressed("dash")
		crouch_pressed = Input.is_action_pressed("crouch")
	
	#camera movement
	camera_look.x = Input.get_axis("look_left","look_right")
	camera_look.y = Input.get_axis("look_up","look_down")
	cam_zoom = Input.is_action_pressed("cam_zoom")
	
	#debug
	if debug_mode == true:
		debug_Xdir = Input.get_axis("move_left", "move_right")
		debug_Ydir = Input.get_axis("jump", "crouch")
		
