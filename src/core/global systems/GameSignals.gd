class_name Game_Signals extends Node

#Game Mechanics
	#Start Game
signal start_game

	#Moiving btwn levels
signal change_level
signal leaving_level(next_level_path)

	#moving btwn menus
signal show_main_menu

	#Player Spawn Location
signal player_spawn(marker_location)

	#Player Health
signal hurt_player(damage)
signal health_changed()
signal reset_player_health
signal player_died

	#Player Movement
signal player_dashed

	#Collectable Counter
signal collectable_collected(value)
signal level_max_collectable(max_collectables)

	#Checkpoint system
signal checkpoint_set(checkpoint_pos)
signal back_to_checkpoint(checkpoint_pos)

#UI
	#Transitions/ Loading Screen
signal start_transition
signal end_transition
