class_name Camera_Component extends Node

@export var camera: Camera2D
@export var cam_speed = 500.0
@export var cam_max_look: int
@export var cam_zoom := Vector2(0.25,0.25)

var cam_direction := Vector2.ZERO
var cam_want_zoom := false


func update() -> void:
	camera.position.x = clamp(0,0,cam_max_look)
	camera.position.x += cam_direction.x * cam_speed
	
	camera.position.y = clamp(0,0,cam_max_look)
	camera.position.y += cam_direction.y * cam_speed
	
	if cam_want_zoom == true:
		camera.zoom = cam_zoom
	elif cam_want_zoom == false:
		camera.zoom = Vector2(0.75,0.75)
