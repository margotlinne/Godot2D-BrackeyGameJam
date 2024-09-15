extends Control


@onready var retry_btn = $Retry
@onready var stamp_img = $BG/Border/Stamp
const fired_path = preload("res://Image/stamp_fired.png")
const promote_path = preload("res://Image/stamp_promoted.png")



func _ready():
	if GameManager.game_over:
		stamp_img.texture = fired_path
		retry_btn.text = "\n Reemployment"
	else: 
		stamp_img.texture = promote_path
		retry_btn.text = "\n Commute Again"





func _on_retry_pressed():
	print("retry")
	GameManager.load_scene("res://Scene/DeskView.tscn")
	GameManager.reset_game = true

func _on_menu_btn_pressed():
	GameManager.load_scene("res://Scene/StartScene.tscn")

