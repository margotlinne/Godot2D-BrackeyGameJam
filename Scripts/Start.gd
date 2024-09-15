extends Control

@onready var anim = $AnimationPlayer
@onready var chat_box = $BG/Button/TextureRect


func _ready():
	anim.play("main_menu")


func _on_button_pressed():
	GameManager.load_scene("res://Scene/DeskView.tscn")
	GameManager.game_started = true



func _on_button_mouse_entered():
	chat_box.get_node("AnimationPlayer").play("chat_box")
	chat_box.show()
	


func _on_button_mouse_exited():
	chat_box.get_node("AnimationPlayer").play("chat_box_disappearing")
	chat_box.hide()
