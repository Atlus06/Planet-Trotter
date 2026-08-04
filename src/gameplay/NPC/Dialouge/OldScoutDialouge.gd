extends Control

@export_file("*.json") var dialouge_file

@onready var Name: RichTextLabel = $MarginContainer/Background/VBoxContainer/Name
@onready var Text: RichTextLabel = $MarginContainer/Background/VBoxContainer/Text

@export var text_speed := 0.015

var dialouge = []
var current_dialouge_id = 0
var dialouge_active := false


func _ready() -> void:
	visible = false

func start():
	if dialouge_active:
		return
	visible = true
	dialouge_active = true
	dialouge = load_dialouge()
	current_dialouge_id = -1
	next_script()

func load_dialouge():
	var file = FileAccess.open("res://src/gameplay/NPC/Dialouge/OldScoutDialouge.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event: InputEvent) -> void:
	if !dialouge_active:
		return
	if event.is_action_pressed("Interact"):
		next_script()

func next_script():
	Text.visible_ratio = 0.0
	
	current_dialouge_id += 1
	if current_dialouge_id >= len(dialouge):
		dialouge_active = false
		visible = false
		return
	
	
	Name.text = dialouge[current_dialouge_id]['name']
	Text.text = dialouge[current_dialouge_id]['text']
	
	
	
	var total_characters = Text.text.length()
	var duration = total_characters * text_speed
	
	var tween = create_tween()
	tween.tween_property(Text, "visible_ratio", 1.0, duration)
