extends "res://src/core/main_game/state_machine.gd"

@onready var movement_component: Movement_Component = %Movement_Component
@onready var state_label: Label = %StateLabel


func _ready() -> void:
	add_states("walk")
	add_states("jump")
	add_states("idle")
	add_states("crouching")
	add_states("dash")
	add_states("wall_slide")
	add_states("falling")
	call_deferred("set_state", states.idle)
	

func state_logic(_delta: float):
	pass

func get_transition(_delta: float):
	match state:
		states.idle:
			if movement_component.direction != 0:
				return states.walk
			elif movement_component.jumping:
				return states.jump
			elif movement_component.is_dashing:
				return states.dash
			elif movement_component.wants_crouch:
				return states.crouching
	
		states.walk:
			if movement_component.direction == 0:
				return states.idle
			elif movement_component.jumping:
				return states.jump 
			elif movement_component.is_dashing:
				return states.dash
			elif movement_component.wants_crouch:
				return states.crouching
			elif !movement_component.body.is_on_floor():
				if movement_component.body.is_on_wall():
					return states.wall_slide
				elif !movement_component.body.is_on_wall():
					if movement_component.body.velocity.y > 0:
						return states.falling
	
		states.jump:
			if movement_component.body.is_on_floor():
				if movement_component.direction == 0:
					return states.idle
				elif movement_component.direction != 0:
					return states.walk
				elif movement_component.wants_crouch:
					return states.crouching
			elif movement_component.body.is_on_wall():
				return states.wall_slide
			elif movement_component.is_dashing:
				return states.dash
			elif !movement_component.body.is_on_floor() and !movement_component.body.is_on_wall():
				if movement_component.body.velocity.y > 0:
					return states.falling
	
		states.dash:
			if movement_component.body.is_on_floor():
				if movement_component.direction == 0:
					return states.idle
				elif movement_component.direction != 0:
					return states.walk
				elif movement_component.wants_crouch:
					return states.crouching
			elif movement_component.body.is_on_wall():
				return states.wall_slide
			elif movement_component.jumping:
				return states.jump
			elif !movement_component.body.is_on_floor() and !movement_component.body.is_on_wall():
				if movement_component.body.velocity.y > 0:
					return states.falling
	
		states.crouching:
			if movement_component.direction != 0:
				if !movement_component.wants_crouch:
					return states.walk
			if movement_component.jumping:
				return states.jump
			elif movement_component.is_dashing:
				return states.dash
			elif !movement_component.wants_crouch:
				return states.idle
	
		states.wall_slide:
			if movement_component.jumping:
				return states.jump
			elif movement_component.is_dashing:
				return states.dash
			elif !movement_component.body.is_on_floor() and !movement_component.body.is_on_wall():
				if movement_component.body.velocity.y > 0:
					return states.falling
	
		states.falling:
			if movement_component.body.is_on_floor():
				if movement_component.direction == 0:
					return states.idle
				elif movement_component.direction != 0:
					return states.walk
				elif movement_component.wants_crouch:
					return states.crouching
			if movement_component.body.velocity.y <= 0:
				if movement_component.jumping:
					return states.jump
				elif movement_component.is_dashing:
					return states.dash
			elif movement_component.body.is_on_wall():
				return states.wall_slide
	
	return null

func enter_state(_new_state, _old_state):
	#pass
	match state:
		states.idle:
			state_label.text = "idle"
			#play from animation conponent
		states.walk:
			state_label.text = "walk"
			#play from animation conponent
		states.jump:
			state_label.text = "jump"
			#play from animation conponent
		states.dash:
			state_label.text = "dash"
			#play from animation conponent
		states.crouching:
			state_label.text = "crouching"
			#play from animation conponent
		states.wall_slide:
			state_label.text = "wall slide"
			#play from animation conponent
		states.falling:
			state_label.text = "falling"
	
	

func exit_state(_new_state, _old_state):
	pass
