extends CharacterBody2D

@onready var dialouge: Control = $Dialouge
@onready var interact_label: Label = $Tutorials/InteractLabel

var is_chatting := false
var player_in_chat_zone: bool = false
var talked_to := false


func _ready() -> void:
	interact_label.visible = false


func _input(event: InputEvent) -> void:
	if is_chatting:
		return
	if player_in_chat_zone:
		if event.is_action_pressed("Interact"):
			print("Player started chat")
			interact_label.visible = false
			is_chatting = true
			dialouge.start()


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if talked_to == false:
			interact_label.visible = true
		player_in_chat_zone = true
		print("player entered chat zone")


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interact_label.visible = false
		player_in_chat_zone = false
		talked_to = true
		print("player left chat zone")
