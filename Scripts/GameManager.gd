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

var email_order = []

const FileClass = preload("res://Scripts/FileClass.gd")
const EmailClass = preload("res://Scripts/EmailClass.gd")

var files_ins
var email_ins

var copied_file 
var right_clicked_file

var total_active_tasks = 0
var assign_first_tasks = false
var assigned = false

# 30초 간격으로 새 이메일 수신 
var interval_timer = 5.0
# 초반 3분 후 5개의 이메일 수신 
var timer = 3
var total_tasks = 0

var set_emails_first = false

var current_paper_work


# Called when the node enters the scene tree for the first time.
func _ready():
	copied_file = "none"
	current_passed_time = Time.get_ticks_msec() / 1000
	current_scene = get_tree().get_current_scene().get_name()
	time_man_pos = Vector2(-370, 20)
	_set_cursor_design()
	
	files_ins = FileClass.new()
	email_ins = EmailClass.new()
	
	total_tasks = email_ins.email_email.size() + email_ins.email_paper.size()
	
	for i in email_ins.email_email:
		i.fileName = files_ins.file[randi() % files_ins.file.size()].name
	
	for i in email_ins.email_email.size():
		_set_random_file()
	#print(email_ins.email_email)
	
	
	await get_tree().create_timer(timer).timeout
	assign_first_tasks = true
	
	
func _process(delta):
	current_passed_time = Time.get_ticks_msec() / 1000
	#print(current_passed_time)
	
	# 초반 태스크 5개 할당 
	if assign_first_tasks && !assigned:
		# 초기 5개 활성화
		for i in range(5):
			_active_random_task()
			#print(total_active_tasks)
		#email_manager.set_visibility()
		_repeat_activate()
		assigned = true

func _repeat_activate():
	while total_active_tasks != total_tasks:
		await get_tree().create_timer(interval_timer).timeout
		_active_random_task()
		#print(total_active_tasks)

func _active_random_task():
	var random_index = 0
	var random = randi() % 2
	var selected_file = null
	if random == 0: 
		random_index = randi_range(0, email_ins.email_email.size() - 1)
		selected_file = email_ins.email_email[random_index]
		print("#", selected_file.from)
	else: 
		random_index =  randi_range(0, email_ins.email_paper.size() - 1)
		selected_file = email_ins.email_paper[random_index]
		print("#", selected_file.from)

	if selected_file.isActive: _active_random_task()
	else:
		if selected_file.isPaperWork:
			for j in email_ins.email_paper:
				if j.from == selected_file.from:
					j.isActive = true
					print("#", j.from, "   ", j.isActive)
					email_order.append(j.from)
					total_active_tasks += 1
					break  # Task assigned, exit loop
		else:
			for j in email_ins.email_email:				
				if j.from == selected_file.from:
					j.isActive = true
					print("#", j.from, "   ", j.isActive)
					email_order.append(j.from)
					total_active_tasks += 1
					break  # Task assigned, exit loop
#		email_manager.get_new_email(selected_file)

func get_item(string, name):
	if string == "email":
		for i in email_ins.email_email:
			if i.from == name:
				return i
	elif string == "paper":
		for i in email_ins.email_paper:
			if i.from == name:
				return i
	elif string == "folder":
		for i in files_ins.file:
			if i.name == name:
				return i
	elif string == "reply":
		for i in email_ins.email_reply:
			if i.from == name:
				return i

func _set_random_file():
	var random = randi() % files_ins.file.size()
	var file_name = files_ins.file[random].name
	#print(file_name)
	for i in email_ins.email_email:
		if i.fileName == file_name:
			_set_random_file()
		elif i == email_ins.email_email[email_ins.email_email.size() - 1]:
			i.fileName = file_name
	
func _get_com_scene():
	if not com_scene_instance:
		var com_scene = preload("res://Scene/Computer.tscn")
		com_scene_instance = com_scene.instantiate()
	return com_scene_instance
	
func load_scene(route):
	get_tree().change_scene_to_file(route)
	current_scene = route.get_file().get_basename()
	_set_cursor_design()
	#print(current_scene)
	
func _set_cursor_design():
	if current_scene == "Computer":
		var cursor_texture = preload("res://Image/MouseCursor.png")  
		var pointing_corsor_texture = preload("res://Image/mouse_pointing.png")
		Input.set_custom_mouse_cursor(pointing_corsor_texture, Input.CURSOR_POINTING_HAND)
		Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	elif current_scene == "DeskView":
		var cursor_texture = preload("res://Image/Cursor.png")
		var pointing_corsor_texture = preload("res://Image/cursor_pointing.png")
		Input.set_custom_mouse_cursor(pointing_corsor_texture, Input.CURSOR_POINTING_HAND)
		Input.set_custom_mouse_cursor(cursor_texture)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif current_scene == "PaperWork":
		Input.set_custom_mouse_cursor(null)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
		#var cursor_texture = preload("res://Image/Cursor.png")
		#Input.set_custom_mouse_cursor(cursor_texture)
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	
