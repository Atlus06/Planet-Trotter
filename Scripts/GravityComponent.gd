class_name Gravity_Component extends Node

var player: CharacterBody2D
@export var gravity_multiplyer := 3.0


func update(delta: float) -> void:
	
	
	# gravity
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * gravity_multiplyer
