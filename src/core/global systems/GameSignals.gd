class_name Game_Signals extends Node

signal change_level
signal leaving_level(next_level_path)

signal player_spawn(marker_location)

signal hurt_player(damage)

signal collectable_collected(value)
signal level_max_collectable(max_collectables)
