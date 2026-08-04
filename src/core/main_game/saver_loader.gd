class_name Saver_Loader
extends Node

@onready var player: Player = %Player

func _ready() -> void:
	load_settings()
	
	GameSignals.save_game.connect(save_game)
	GameSignals.load_game.connect(load_game)
	
	GameSignals.save_settings.connect(save_settings)
	GameSignals.load_settings.connect(load_settings)




func save_game():
	#print("Game Saved")
	
	var saved_game: SavedGame = SavedGame.new()
	
	saved_game.player_health = player.player_health
	saved_game.player_pos = player.player_position
	save_settings()
	
	ResourceSaver.save(saved_game, "user://savegame.tres")
	

func load_game():
	#print("Game Loaded")
	
	var saved_game: SavedGame = load("user://savegame.tres")
	
	player.global_position = saved_game.player_pos
	player.player_health = saved_game.player_health
	



func save_settings():
	#print("Settings Saved")
	
	var config = ConfigFile.new()
	for action in ["move_left","move_right","jump","dash","crouch","look_up","look_down","look_left","look_right"]:
		var events = InputMap.action_get_events(action)
		if events.size() >0:
			config.set_value("Input", action, events)
	
	var current_screen_mode = DisplayServer.window_get_mode()
	config.set_value("Video","window_mode",current_screen_mode)
	
	config.save("user://saved_settings.cfg")
	
	get_tree().call_group("rebind_buttons", "update_display")

func load_settings():
	#print("Settings Loaded")
	
	var config = ConfigFile.new()
	var err = config.load("user://saved_settings.cfg")
	
	if err != OK:
		return
	
	
	for action in config.get_section_keys("Input"):
		var saved_events_array = config.get_value("Input", action)
		InputMap.action_erase_events(action)
		
		for single_event in saved_events_array:
			if single_event is InputEvent:
				InputMap.action_add_event(action, single_event)
	
	get_tree().call_group("rebind_buttons", "update_display")
	
	var saved_screen_mode = config.get_value("Video","window_mode",DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_mode(saved_screen_mode)
	
