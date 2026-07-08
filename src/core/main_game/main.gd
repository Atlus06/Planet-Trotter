extends Node

@onready var LevelRoot = get_node("World/LevelRoot")
@onready var EntityRoot = get_node("World/EntityRoot")
@onready var player: Player = $World/EntityRoot/Player


func _ready() -> void:
	load_start()
	
	GameSignals.leaving_level.connect(switch_level)
	GameSignals.player_spawn.connect(set_player_pos)
	

func load_start():
	GameSignals.start_transition.emit()
	
	if LevelRoot.get_child_count() == 0:
		var start_level = load("res://src/levels/levels/start_level_test.tscn")
		if start_level:
			var new_level_instance = start_level.instantiate()
			LevelRoot.call_deferred("add_child", new_level_instance)
	
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
	
	if player.global_position == marker_location:
		GameSignals.end_transition.emit()
