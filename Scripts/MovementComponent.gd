class_name Movement_Component extends Node
@onready var dash_timer: Timer = $"../DashTimer"

@export var body: CharacterBody2D
@export var speed := 500.0
@export var jump_velo := -900.0
@export var dash_velo := 15.0
@export var gravity_multiplyer := 3.0

var direction: float
var jumping := false
var jump_held := 0
var CanJump := false
var wants_dash := false
var is_dashing := false
var CanDash := false

func update(delta: float) -> void:
	#if no body then no moevement
	if body == null:
		return
	#skips everything to let dash finish
	if is_dashing:
		body.move_and_slide()
		return
	
	# movement
	body.velocity.x = direction * speed
	
	# gravity
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplyer
	
	# can jump/dash
	if body.is_on_floor():
		CanJump = true
		CanDash = true
	
	#jump
	if jumping and body.is_on_floor():
		body.velocity.y = jump_velo
	elif jumping and CanJump == true:
		body.velocity.y = jump_velo
		CanJump = false
		
	#dash
	if wants_dash and CanDash == true:
		dash_timer.start()
		var dash_dir = Vector2(-direction,jump_held)
		if dash_dir == Vector2(0,0):
			dash_dir = Vector2(0,1)
		body.velocity = dash_dir * dash_velo
		
		CanDash = false
		is_dashing = true
	
	#wall clinging
	if body.is_on_wall():
		if direction != 0:
			body.velocity.y = 35
			CanDash = true
			CanJump = true
	
	
	body.move_and_slide()


func _on_dash_timer_timeout() -> void:
	is_dashing = false
