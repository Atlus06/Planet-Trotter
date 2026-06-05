extends CharacterBody2D

@onready var input_component: Input_Component = $Input_Component
@onready var movement_component: Movement_Component = %Movement_Component
@onready var gravity_component: Gravity_Component = %Gravity_Component
@onready var camera_component: Camera_Component = %Camera_Component

func _physics_process(delta: float) -> void:
	
	#Reads input
	input_component.update()
	
	#Handles movement
	movement_component.direction = input_component.move_direction
	movement_component.Ydirection = input_component.aim_direction
	movement_component.jumping = input_component.jump_pressed
	movement_component.wants_dash = input_component.dash_pressed
	movement_component.wants_slide = input_component.slide_pressed
	movement_component.handle_slide(delta)
	movement_component.update(delta)
	
	#applies gravity
	gravity_component.player = movement_component.body
	gravity_component.update(delta)
	
	#camera movement
	camera_component.cam_direction = input_component.camera_look
	camera_component.cam_want_zoom = input_component.cam_zoom
	camera_component.update()
	
	
	
