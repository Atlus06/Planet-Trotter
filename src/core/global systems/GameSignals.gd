class_name Game_Signals extends Node

#Game Mechanics
	#Moiving btwn levels
signal change_level
signal leaving_level(next_level_path)

	#Player Spawn Location
signal player_spawn(marker_location)

	#Player Damage
signal hurt_player(damage)

	#Collectable Counter
signal collectable_collected(value)
signal level_max_collectable(max_collectables)

#UI
	#Transitions/ Loading Screen
signal start_transition
signal end_transition
