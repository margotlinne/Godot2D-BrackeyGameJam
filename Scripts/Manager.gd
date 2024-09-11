extends Control

@onready var ui_control = $"../UI"

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_control.show()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"): 
		ui_control.hide()
		GameManager.com_scene_instance = get_tree().current_scene
		GameManager.load_scene("res://Scene/DeskView.tscn")


func _on_button_pressed():
	ui_control.hide()
