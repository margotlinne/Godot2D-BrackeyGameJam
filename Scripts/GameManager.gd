extends Node2D

var current_scene
var time_man_pos
var current_passed_time

var show_ui = false

var com_scene_instance: Node = null

var bin_open
var shopping_open
var email_open
var game_open
var folder_open
var note_open

var child_order = []

const FileClass = preload("res://Scripts/FileClass.gd")

var files_ins
	
var right_clicked_file


# Called when the node enters the scene tree for the first time.
func _ready():
	current_passed_time = Time.get_ticks_msec() / 1000
	current_scene = get_tree().get_current_scene().get_name()
	time_man_pos = Vector2(-370, 20)
	_set_cursor_design()
	
	files_ins = FileClass.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_passed_time = Time.get_ticks_msec() / 1000
	#print(current_passed_time)
	
func _get_com_scene():
	if not com_scene_instance:
		var com_scene = preload("res://Scene/Computer.tscn")
		com_scene_instance = com_scene.instantiate()
	return com_scene_instance
	
		

func load_scene(route):
	get_tree().change_scene_to_file(route)
	current_scene = route.get_file().get_basename()
	_set_cursor_design()
	print(current_scene)
	
func _set_cursor_design():
	if current_scene == "Computer":
		var cursor_texture = preload("res://Image/MouseCursor.png")  
		var pointing_corsor_texture = preload("res://Image/mouse_pointing.png")
		Input.set_custom_mouse_cursor(pointing_corsor_texture, Input.CURSOR_POINTING_HAND)
		Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	elif current_scene == "DeskView":
		var cursor_texture = preload("res://Image/Cursor.png")
		Input.set_custom_mouse_cursor(cursor_texture)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif current_scene == "PaperWork":
		Input.set_custom_mouse_cursor(null)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

	
