extends Node

@onready var LevelRoot = get_node("World/LevelRoot")
@onready var EntityRoot = get_node("World/EntityRoot")
@onready var player: Player = $World/EntityRoot/Player


func _ready() -> void:
	GameSignals.start_game.connect(load_start)
	GameSignals.leaving_level.connect(switch_level)
	GameSignals.player_spawn.connect(set_player_pos)
	GameSignals.player_died.connect(on_player_death)
	GameSignals.back_to_checkpoint.connect(reset_to_checkpoint)
	

func load_start():
	GameSignals.start_transition.emit()
	
	if LevelRoot.get_child_count() == 0:
		var start_level = load("res://src/levels/levels/start_level_test.tscn")
		if start_level:
			var new_level_instance = start_level.instantiate()
			LevelRoot.call_deferred("add_child", new_level_instance)
	
	set_player_pos(GameVariables.last_checkpoint_pos)
	
	GameSignals.end_transition.emit()

func switch_level(new_level_path: String):
	#print("Changed level")
	GameSignals.start_transition.emit()
	
	if LevelRoot.get_child_count() > 0:
		var current_level = LevelRoot.get_child(0)
		current_level.queue_free()
	
	var level_scene = load(new_level_path)
	if level_scene:
		var new_level_instance = level_scene.instantiate()
		LevelRoot.call_deferred("add_child", new_level_instance)
	
	
	
	
	#LevelRoot.add_child.call_deferred(new_level_instance)
	

func set_player_pos(marker_location: Vector2):
	player.global_position = marker_location
	GameSignals.reset_player_health.emit(null)
	if player.global_position == marker_location:
		GameSignals.end_transition.emit()

func on_player_death(respawn_location):
	GameSignals.start_transition.emit()
	
	set_player_pos(respawn_location)

func reset_to_checkpoint(marker_location: Vector2):
	GameSignals.start_transition.emit()
	player.global_position = marker_location
	if player.global_position == marker_location:
		GameSignals.end_transition.emit()
