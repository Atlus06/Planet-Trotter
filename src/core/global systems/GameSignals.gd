class_name Game_Signals extends Node

#Game Mechanics
	#Start Game
signal start_game

	#Moving btwn levels
signal change_level
signal leaving_level(next_level_path)

	#important misc stuff
signal show_main_menu

	#Saving & Loading
signal save_game
signal save_settings
signal load_game
signal load_settings

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
signal collected_all_collectables

	#Checkpoint system
signal checkpoint_set(checkpoint_pos)
signal back_to_checkpoint(checkpoint_pos)

	#Levels
signal entering_level_1(level_number)
signal entering_level_2(level_number)
signal entering_level_3(level_number)
signal entering_level_4(level_number)
signal entering_level_5(level_number)


#UI
	#Transitions/ Loading Screen
signal start_transition
signal end_transition

	#Settings - Show FPS
signal show_fps
signal hide_fps
