extends CharacterBody2D

@onready var input_component: Input_Component = $Input_Component
@onready var movement_component: Movement_Component = %Movement_Component
@onready var gravity_component: Gravity_Component = %Gravity_Component

func _physics_process(delta: float) -> void:
	
	#Reads input
	input_component.update()
	
	#Handles movement
	movement_component.direction = input_component.move_direction
	movement_component.jumping = input_component.jump_pressed
	movement_component.wants_dash = input_component.dash_pressed
	movement_component.jump_held = input_component.up_held
	movement_component.update(delta)
	
	#applies gravity
	gravity_component.player = movement_component.body
	gravity_component.update(delta)
	
	
