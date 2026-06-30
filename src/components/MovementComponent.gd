class_name Movement_Component extends Node
@onready var dash_timer: Timer = $"../DashTimer"
@onready var wall_jump: Timer = $"../WallJump"
@onready var dash_cooldown: Timer = $"../DashCooldown"
@onready var coyote_timer: Timer = $"../CoyoteTimer"

@export var body: CharacterBody2D
@export var speed := 500.0
@export var jump_velo := -900.0
#@export var wall_jump_velo = -1100.0
@export var dash_velo := -1500.0

var direction: float
var was_on_floor := false

var jumping := false
var Ydirection: float
var CanJump := false
var CanDJump := false
var is_wall_jumping := false

var wants_dash := false
var is_dashing := false
var CanDash := false

var wants_crouch := false
var wants_slide := false
var is_sliding := false
var canslide := true
var slide_speed: float
var slide_stop_tres := 100.0
var slide_deceleration := 50.0
var initial_slide_velo := 1500.0
var min_slide_tres := 200.0

func update(delta: float) -> void:
	#if no body then no moevement
	if body == null:
		return
	#skips everything to let dash/walljump finish
	if is_dashing or is_wall_jumping or is_sliding:
		body.move_and_slide()
		return
	
	
	# movement
	body.velocity.x = direction * speed
	
	
	# can jump/dash
	if body.is_on_floor() or body.is_on_wall():
		CanJump = true
		CanDash = true
		CanDJump = true
		was_on_floor = true
	
	#jump
	if jumping and CanJump:
		jump()
		#print("normal jump")
	elif jumping and CanDJump and not body.is_on_floor():
		jump()
		#print("double jump")
	
	if body.is_on_floor() == false and CanJump and coyote_timer.is_stopped():
		coyote_timer.start()
	
		
		
	#dash
	if wants_dash and CanDash == true:
		dash_timer.start()
		var dash_dir = Vector2(-direction,-Ydirection)
		if dash_dir == Vector2(0,0):
			dash_dir = Vector2(0,1)
		body.velocity = dash_dir * dash_velo
		
		CanDash = false
		is_dashing = true
	
	
	#wall clinging
	if body.is_on_wall():
		if direction != 0:
			body.velocity.y = 35
	
	#jump away from wall
	if jumping:
		if body.is_on_wall():
			var wall_normal = body.get_wall_normal()
			
			body.velocity.x = -wall_normal.x * jump_velo
			body.velocity.y = jump_velo
			
			wall_jump.start()
			is_wall_jumping = true
	
	handle_slide()
	
	body.move_and_slide()



func jump():
	body.velocity.y = jump_velo
	if body.is_on_floor():
		CanJump = false
	elif was_on_floor:
		CanDJump = false


func handle_slide() -> void:
		#slide/ crouch
	#if wants_slide and direction == 0:
		#wants_crouch = true
	
	if body.is_on_floor() and wants_slide and abs(body.velocity.x) > min_slide_tres and canslide:
		if is_sliding == false:
			is_sliding = true
			#print("slide started")
			dash_cooldown.start()
			canslide = false
			
			body.velocity.x = initial_slide_velo * body.velocity.normalized().x
	
	if is_sliding:
		body.velocity.x = move_toward(body.velocity.x, 0, slide_deceleration)
		
		if abs(body.velocity.x) <= slide_stop_tres:
			stop_sliding()
			#print("slide stopped: stop treshold")
		elif wants_slide == false:
			stop_sliding()
			#print("slide stopped: button released")



func _on_dash_timer_timeout() -> void:
	is_dashing = false

func _on_wall_jump_timeout() -> void:
	is_wall_jumping = false

func stop_sliding() -> void:
	is_sliding = false

func _on_dash_cooldown_timeout() -> void:
	canslide = true


func _on_coyote_timer_timeout() -> void:
	CanJump = false
