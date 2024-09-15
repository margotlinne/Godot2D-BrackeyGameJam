extends Control

@onready var anim = $AnimationPlayer


func _ready():
	anim.play("main_menu")


func _on_button_pressed():
	GameManager.load_scene("res://Scene/DeskView.tscn")
	GameManager.game_started = true
