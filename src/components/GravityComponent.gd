class_name Gravity_Component extends Node

var player: CharacterBody2D
@export var gravity_multiplyer := 4.0

var debug_mode: bool

func update(delta: float) -> void:
	# gravity
	if debug_mode == false:
		if not player.is_on_floor():
			player.velocity += player.get_gravity() * gravity_multiplyer * delta
		#print(player.get_gravity())
		#print(player.get_gravity() * gravity_multiplyer * delta)
