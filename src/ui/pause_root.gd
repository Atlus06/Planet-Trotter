extends Control

@onready var pause_menu: MarginContainer = $PauseMenu


var is_paused: bool
var is_transitioning: bool
func _ready() -> void:
	is_paused = false
	pause_menu.visible = false
	
	

func _input(event: InputEvent) -> void:
	if is_transitioning == true:
		return
	if event.is_action_pressed("Pause") and is_paused == false:
		#print(is_paused)
		pause_game()
	elif event.is_action_pressed("Pause") and is_paused == true:
		#print(is_paused)
		unpause_game()

func pause_game():
	is_paused = true
	pause_menu.visible = true
	get_tree().paused = true

func unpause_game():
	is_paused = false
	pause_menu.visible = false
	get_tree().paused = false


func _on_resume_button_pressed() -> void:
	unpause_game()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_save_quit_button_pressed() -> void:
	#GameSignals.start_transition.emit()
	
	#code to save game
	
	await get_tree().create_timer(0.5).timeout
	
	GameSignals.show_main_menu.emit()
	unpause_game()
	#GameSignals.end_transition.emit()
