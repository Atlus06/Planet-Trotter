class_name Movement_Component extends Node
@onready var dash_timer: Timer = $"../DashTimer"
@onready var dash_cooldown: Timer = $"../DashCooldown"
@onready var coyote_timer: Timer = $"../CoyoteTimer"
@onready var wall_jump_timer: Timer = $"../WallJumpTimer"

@export var body: CharacterBody2D
@export var speed := 500.0
@export var jump_velo := 1000.0
@export var wall_push_velo := 950.0
@export var wall_jump_velo := 1200.0
@export var dash_velo := -1500.0

var direction: float

var jumping := false
var Ydirection: float
var CanJump := true
var CanDJump := false
var is_wall_jumping := false
var wall_jump_drag := 0.0

var wants_dash := false
var is_dashing := false
var CanDash := true

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
	#skips everything to let dash finish
	if is_dashing or is_sliding or is_wall_jumping:
		body.move_and_slide()
		return
	
	# movement
	body.velocity.x = direction * speed
	
		# can jump/dash
	if body.is_on_floor():
		CanJump = true
		CanDJump = true
		CanDash = true
	
	if body.is_on_wall():
		CanDash = true
	
	#wall clinging
	if body.is_on_wall() and not body.is_on_floor():
		if direction != 0:
			body.velocity.y = min(body.velocity.y, 40)
	
	#jump
	if jumping:
		jump()
	
	#dash
	if wants_dash and CanDash == true:
		dash()
	
	#wall jump
	if body.is_on_wall() and not body.is_on_floor():
		if direction != 0 and jumping:
			wall_jump()
	
	
	#handle_crouch()  --  Make into working crouch
	
	
	body.move_and_slide()


func jump():
	if jumping and CanJump:
		body.velocity.y = -jump_velo
		CanJump = false
		#print("normal jump")
	elif jumping and CanDJump and not body.is_on_floor():
		body.velocity.y = -jump_velo
		#print("double jump")
		CanDJump = false

	if body.is_on_floor() == false and CanJump and coyote_timer.is_stopped():
		coyote_timer.start()
	
	

func dash():
	dash_timer.start()
	var dash_dir = Vector2(-direction,-Ydirection)
	if dash_dir == Vector2(0,0):
		dash_dir = Vector2(0,1)
	body.velocity = dash_dir * dash_velo
	
	CanDash = false
	is_dashing = true
	
	dash_cooldown.start()

func wall_jump():
	var wall_normal = body.get_wall_normal()
	
	body.velocity.x = wall_normal.x * wall_push_velo
	body.velocity.y = -wall_jump_velo
	
	wall_jump_timer.start()
	is_wall_jumping = true
	
	

func handle_crouch() -> void:
	pass



func _on_dash_timer_timeout() -> void:
	is_dashing = false

func stop_sliding() -> void:
	is_sliding = false

func _on_dash_cooldown_timeout() -> void:
	CanDash = true

func _on_coyote_timer_timeout() -> void:
	CanJump = false

func _on_wall_jump_timer_timeout() -> void:
	is_wall_jumping = false
