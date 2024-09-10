extends Node2D

var current_scene
var current_time_pos
var current_passed_time

# Called when the node enters the scene tree for the first time.
func _ready():
	current_time_pos = Vector2(0,0)
	current_passed_time = 0
	
	current_scene = get_tree().get_current_scene().get_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_scene == "Computer":
		var cursor_texture = preload("res://Image/MouseCursor.png")  
		Input.set_custom_mouse_cursor(cursor_texture)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif current_scene == "DeskView":
		var cursor_texture = preload("res://Image/Cursor.png")
		Input.set_custom_mouse_cursor(cursor_texture)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif current_scene == "PaperWork":
		Input.set_custom_mouse_cursor(null)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass
		

func load_scene(route):
	get_tree().change_scene_to_file(route)
	current_scene = route.get_file().get_basename()
	print(current_scene)
	
	
