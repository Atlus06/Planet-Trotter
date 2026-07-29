extends Control

@onready var rebind_menu: Control = $RebindMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rebind_menu.visible = false
	rebind_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false


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
