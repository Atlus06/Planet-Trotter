class_name Input_Component extends Node

var move_direction: float
var jump_pressed := false
var dash_pressed := false
var up_held := 0

var camera_look = Vector2.ZERO
var cam_zoom = false

func update() -> void:
	#character movement
	move_direction = Input.get_axis("move_left", "move_right")
	jump_pressed = Input.is_action_just_pressed("jump")
	dash_pressed = Input.is_action_just_pressed("dash")
	up_held = Input.is_action_pressed("jump")
	
	#camera movement
	camera_look.x = Input.get_axis("look_left","look_right")
	camera_look.y = Input.get_axis("look_up","look_down")
	cam_zoom = Input.is_action_pressed("cam_zoom")
	
