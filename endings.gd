extends Node

signal end_game

var ending_1 := false
var ending_2 := false
var ending_3 := false


var level_1_collected: bool
var level_2_collected: bool
var level_3_collected: bool
var level_4_collected: bool
var level_5_collected: bool


func _ready() -> void:
	end_game
	GameSignals.collected_all_collectables.connect(max_collectable_tracker)

func max_collectable_tracker(current_level):
	if current_level == 1:
		level_1_collected = true
		print("Level 1 Completed")
	if current_level == 2:
		level_2_collected = true
		print("Level 2 Completed")
	if current_level == 3:
		level_3_collected = true
		print("Level 3 Completed")
	if current_level == 4:
		level_4_collected = true
		print("Level 4 Completed")
	if current_level == 5:
		level_5_collected = true
		print("Level 5 Completed")
		
	
	if (level_1_collected and level_2_collected and level_3_collected and level_4_collected and level_5_collected) == true:
		print("you collected everything")
		ending_2 = true
	else:
		ending_1 = true
		ending_2 = false
