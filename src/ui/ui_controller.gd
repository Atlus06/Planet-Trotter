extends Node

@onready var HudRoot: Control = $HudLayer/HudRoot
@onready var PauseRoot: Control = $PauseLayer/PauseRoot
@onready var TransitionRoot: Control = $TransitionLayer/TransitionRoot
@onready var main_menu_root: Control = $MainMenuLayer/MainMenuRoot
@onready var settings_menu: Control = %SettingsMenu

func _process(delta: float) -> void:
	#make it so pausing during transition doesn't break game
	PauseRoot.is_transitioning = TransitionRoot.is_transitioning
	PauseRoot.in_MainMenu = main_menu_root.in_MainMenu
