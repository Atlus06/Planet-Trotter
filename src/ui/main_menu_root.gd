extends Control

@onready var background_rect: ColorRect = $BackgroundRect
@onready var main_menu: MarginContainer = $MainMenu
@onready var settings_menu: Control = %SettingsMenu

var in_MainMenu: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameSignals.show_main_menu.connect(show_main_menu)
	settings_menu.visible = false
	



func show_main_menu():
	background_rect.visible = true
	main_menu.visible = true
	in_MainMenu = true
	




func _on_start_button_pressed() -> void:
	#print("Pressed Start Game")
	
	GameSignals.start_game.emit()
	GameSignals.load_game.emit()
	background_rect.visible = false
	main_menu.visible = false
	in_MainMenu = false


func _on_settings_button_pressed() -> void:
		settings_menu.visible = true


func _on_quit_button_pressed() -> void:
	#print("Pressed Quit Game")
	GameSignals.save_game.emit()
	get_tree().quit()
