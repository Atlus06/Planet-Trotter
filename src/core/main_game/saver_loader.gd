class_name Saver_Loader
extends Node

@onready var player: Player = %Player

func _ready() -> void:
	GameSignals.save_game.connect(save_game)
	GameSignals.load_game.connect(load_game)

#temp
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("TempSave"):
		GameSignals.save_game.emit()
	elif Input.is_action_just_pressed("TempLoad"):
		GameSignals.load_game.emit()
	else:
		return

func save_game():
	print("Game Saved")
	
	var saved_game: SavedGame = SavedGame.new()
	
	saved_game.player_health = player.player_health
	saved_game.player_pos = player.player_position
	
	ResourceSaver.save(saved_game, "user://savegame.tres")
	

func load_game():
	print("Game Loaded")
	
	var saved_game: SavedGame = load("user://savegame.tres")
	
	player.global_position = saved_game.player_pos
	player.player_health = saved_game.player_health
	
