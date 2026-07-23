extends Control

@onready var background_rect: ColorRect = $BackgroundRect
@onready var main_menu: MarginContainer = $MainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameSignals.show_main_menu.connect(show_main_menu)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func show_main_menu():
	background_rect.visible = true
	main_menu.visible = true



func _on_start_button_pressed() -> void:
	#print("Pressed Start Game")
	GameSignals.start_game.emit()
	background_rect.visible = false
	main_menu.visible = false


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	#print("Pressed Quit Game")
	get_tree().quit()
