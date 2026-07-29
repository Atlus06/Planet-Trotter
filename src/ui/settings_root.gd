extends Control

@onready var rebind_menu: Control = $RebindMenu
@onready var fps_button: Button = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/FPSButton
@onready var screen_option_button: OptionButton = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer2/ScreenOptionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rebind_menu.visible = false
	rebind_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	
	var current_screen_mode = DisplayServer.window_get_mode()
	match current_screen_mode:
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			screen_option_button.select(0)
		DisplayServer.WINDOW_MODE_MAXIMIZED:
			screen_option_button.select(1)
		DisplayServer.WINDOW_MODE_WINDOWED:
			screen_option_button.select(2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_to_rebind_menu_pressed() -> void:
	rebind_menu.visible = true
	rebind_menu.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_done_button_pressed() -> void:
	GameSignals.save_settings.emit()
	rebind_menu.visible = false
	rebind_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_reset_key_button_pressed() -> void:
	InputMap.load_from_project_settings()
	GameSignals.save_settings.emit()
	get_tree().call_group("rebind_buttons", "update_display")


func _on_fps_button_pressed() -> void:
	if fps_button.button_pressed:
		fps_button.text = "ON"
		GameSignals.show_fps.emit()
		print("show fps")
	else:
		fps_button.text = "OFF"
		GameSignals.hide_fps.emit()
		print("hide fps")


func _on_screen_option_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
	
