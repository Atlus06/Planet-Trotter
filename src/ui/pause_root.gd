extends Control

@onready var pause_rect: ColorRect = $PauseRect

var is_paused: bool
var is_transitioning: bool
func _ready() -> void:
	is_paused = false
	pause_rect.visible = false
	
	GameSignals.start_transition.connect(disable_pause)
	GameSignals.end_transition.connect(disable_pause)

func disable_pause():
	var game_paused = get_tree().paused
	

func _input(event: InputEvent) -> void:
	if is_transitioning == true:
		return
	if event.is_action_pressed("Pause") and is_paused == false:
		print(is_paused)
		is_paused = true
		pause_rect.visible = true
		get_tree().paused = true
	elif event.is_action_pressed("Pause") and is_paused == true:
		print(is_paused)
		is_paused = false
		pause_rect.visible = false
		get_tree().paused = false
