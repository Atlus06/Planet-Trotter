extends Control

@onready var pause_menu: MarginContainer = $PauseMenu
@onready var settings_menu: Control = %SettingsMenu



var is_paused: bool
var is_transitioning: bool
var in_MainMenu: bool


func _ready() -> void:
	is_paused = false
	pause_menu.visible = false
	settings_menu.visible = false



func _input(event: InputEvent) -> void:
	if is_transitioning == true or in_MainMenu == true:
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


func _on_back_2_checkpoint_button_pressed() -> void:
	GameSignals.back_to_checkpoint.emit(GameVariables.last_checkpoint_pos)
	unpause_game()


func _on_settings_button_pressed() -> void:
	settings_menu.visible = true


func _on_save_quit_button_pressed() -> void:
	#GameSignals.start_transition.emit()
	
	#code to save game
	GameSignals.save_game.emit()
	
	await get_tree().create_timer(0.5).timeout
	
	GameSignals.show_main_menu.emit()
	unpause_game()
	#GameSignals.end_transition.emit()


func _on_done_button_pressed() -> void:
	settings_menu.visible = false
