class_name Input_Component extends Node

var move_direction: float
var jump_pressed := false
var dash_pressed := false
var up_held := 0
func update() -> void:
	move_direction = Input.get_axis("move_left", "move_right")
	jump_pressed = Input.is_action_just_pressed("jump")
	dash_pressed = Input.is_action_just_pressed("dash")
	up_held = Input.is_action_pressed("jump")
	
