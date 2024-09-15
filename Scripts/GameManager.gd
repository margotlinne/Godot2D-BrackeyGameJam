extends Node2D

var current_scene
var time_man_pos
var current_passed_time

var show_ui = false

var com_scene_instance: Node = null

var bin_open
var bin_closed
var shopping_open
var shopping_closed
var email_open
var email_closed
var game_open
var game_closed
var folder_open
var folder_closed
var note_open
var note_closed

var active_windows = []

var child_order = []

var email_order = []

const FileClass = preload("res://Scripts/FileClass.gd")
const EmailClass = preload("res://Scripts/EmailClass.gd")

var files_ins
var email_ins

var card_high_score = 0

var copied_file 
var right_clicked_file

var total_active_tasks = 0
var assign_first_tasks = false
var assigned = false

var previous_card = 0
var current_card = 0
var current_score = 0
var card_color = -1
var card_started = false
var card_icon = -1
var card_failed  = false

var game_timer = 600.0
# 30초 간격으로 새 이메일 수신 
var interval_timer = 30.0
# 초반 3분 후 5개의 이메일 수신 
var timer = 180.0
var total_tasks = 0
var time_point = 0
var set_emails_first = false

var current_paper_work
var hearts = 5

var game_over = false

var reset_game = false
var to_end_scene = false
var game_started = false
var set_time = false

var actual_time = 0

@onready var bg_ambient = preload("res://Sfx/office-ambience.mp3")
@onready var notification = preload("res://Sfx/email_notification.mp3")
@onready var hurt = preload("res://Sfx/argg.mp3")
@onready var crying = preload("res://Sfx/crying.mp3")
@onready var promoted = preload("res://Sfx/promoted.mp3")

func _ready():	
	# 게임 시작부터 실제로 흐른 시간
	actual_time = Time.get_ticks_msec() / 1000
	time_point = 0
		
	#current_passed_time = -100
	copied_file = null
#	current_passed_time = Time.get_ticks_msec() / 1000
	current_scene = get_tree().get_current_scene().get_name()
	time_man_pos = Vector2(-370, 20)
	_set_cursor_design()
	
	files_ins = FileClass.new()
	email_ins = EmailClass.new()
	
	_set_file_data()
	
	total_tasks = email_ins.email_email.size() + email_ins.email_paper.size()
	
	for i in email_ins.email_email:
		i.fileName = files_ins.file[randi() % files_ins.file.size()].name
	
	for i in email_ins.email_email.size():
		_set_random_file()
	#print(email_ins.email_email)
	
	
#	await get_tree().create_timer(timer).timeout
#	assign_first_tasks = true
	
#func _get_elapsed_time(time_point):
#	return Time.get_ticks_msec() / 1000 - time_point


func _test_man_pos():
	while true:
		await get_tree().create_timer(1.0).timeout
		print(time_man_pos)

func _process(delta):
	
	
	
	actual_time = Time.get_ticks_msec() / 1000
	#current_passed_time = _get_elapsed_time(time_point)
	#_test_man_pos()
	#print(game_timer, " is total time   ",actual_time, "  game started at : ", time_point, " game over?: ", game_over)
	if game_started and !set_time:		
		print("#########################################################")
		var audio_player = AudioStreamPlayer2D.new()
		add_child(audio_player)
		audio_player.stream = bg_ambient
		audio_player.autoplay = true
		audio_player.play()
		#print("total time: ", Time.get_ticks_msec(), "\nset current_passed_time: ", current_passed_time)
		
		time_point = actual_time
		set_time = true
	if set_time:
		game_timer -= delta
		if !assign_first_tasks:
			#await get_tree().create_timer(timer).timeout
			if game_timer <= game_timer - timer:
				assign_first_tasks = true
			#print(assign_first_tasks)
	
	# 초반 태스크 5개 할당 
	if assign_first_tasks && !assigned:
		# 초기 5개 활성화
		for i in range(5):
			_active_random_task()
			#print(total_active_tasks)
		#email_manager.set_visibility()
		_repeat_activate()
		assigned = true

		
	if game_timer <= 0.0 and !to_end_scene:
		var count = 0
		for task in email_ins.email_reply:
			if task.isDone: count += 1
		# 모든 태스크를 끝낸 상태라면 
		if count == email_ins.email_reply.size():
			_game_success()
		else: _game_failed()
		
		to_end_scene = true
		print(count)
		
		
	if reset_game: 
		_reset_game()
		reset_game = false
	#print(current_passed_time)
	
			
	if hearts <= 0 && !to_end_scene: 
		_game_failed()
		to_end_scene = true

func _game_success():
	time_man_pos = Vector2(-370, 20)
	for i in get_children():
		if i.stream == bg_ambient: remove_child(i)
	var audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.stream = promoted
	audio_player.autoplay = true
	audio_player.play()
		
	load_scene("res://Scene/EndScene.tscn")
	
func _game_failed():
	time_man_pos = Vector2(-370, 20)
	for i in get_children():
		if i.stream == bg_ambient: remove_child(i)
	var audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.stream = crying
	audio_player.autoplay = true
	audio_player.play()
		
	game_over = true
	load_scene("res://Scene/EndScene.tscn")


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
		#print("#", selected_file.from)
	else: 
		random_index =  randi_range(0, email_ins.email_paper.size() - 1)
		selected_file = email_ins.email_paper[random_index]
		#print("#", selected_file.from)

	if selected_file.isActive: _active_random_task()
	else:
		if selected_file.isPaperWork:
			for j in email_ins.email_paper:
				if j.from == selected_file.from:
					j.isActive = true
					#print("#", j.from, "   ", j.isActive)
					email_order.append(j.from)
					total_active_tasks += 1
					break  # Task assigned, exit loop
		else:
			for j in email_ins.email_email:				
				if j.from == selected_file.from:
					j.isActive = true
					#print("#", j.from, "   ", j.isActive)
					email_order.append(j.from)
					total_active_tasks += 1
					break  # Task assigned, exit loop
#		email_manager.get_new_email(selected_file)
	
	var audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.stream = notification
	if current_scene != "Computer": audio_player.volume_db = -30
	else: audio_player.volume_db = -3
	audio_player.play()

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

func get_reply(sender, failed, done):
	var timer = 1.0
	await get_tree().create_timer(timer).timeout
	
	email_order.append(sender + "reply")
	var item = get_item("reply", sender)
	item.isActive = true
	
	if failed || !done:
		var audio_player = AudioStreamPlayer2D.new()
		add_child(audio_player)
		audio_player.stream = hurt
		audio_player.play()
		item.setScore = true
		hearts -= 1
	#mail_container.add_child(new_mail_box)
#	for i in email_items:
#		if i.from_text.text == email.from_text.text && i.is_reply:
#			i.is_active = true
			
	#item.set_reply_datas(item.from, !item.isFailed, item.isActive, \
	#item.profilePath, item.withFile, item.isPaperWork)	


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
	#print("set cursor")
	if current_scene == "Computer":
		var cursor_texture = preload("res://Image/MouseCursor.png")  
		var pointing_corsor_texture = preload("res://Image/mouse_pointing.png")
		Input.set_custom_mouse_cursor(pointing_corsor_texture, Input.CURSOR_POINTING_HAND)
		Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	elif current_scene == "DeskView" || current_scene == "EndScene" || current_scene == "StartScene":
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


func _set_file_data():
	var random = randi_range(6, 15)
	var count = 0
	while count < random:
		var rand_index = randi_range(0, files_ins.file.size() - 1)
		for file in files_ins.file:
			if files_ins.file[rand_index] == file:
				if not file.inBin:
					file.inBin = true
					count += 1
				else: break
		

func _reset_email_data():
	for i in email_ins.email_email:
		i.isActive = false
		i.isFailed = false
		i.isDone = false
		i.isReply = false
		i.withFile = false
		i.isSent = false
		i.setScore = false
	for i in email_ins.email_paper:
		i.isActive = false
		i.isFailed = false
		i.isDone = false
		i.isReply = false
		i.withFile = false
		i.isSent = false
		i.setScore = false
	for i in email_ins.email_reply:
		i.isActive = false
		i.isFailed = false
		i.isDone = false
		i.isReply = true
		i.withFile = false
		i.isSent = false
		i.setScore = false

func _reset_game():
	for i in get_children():
		if i.stream == crying: remove_child(i)
		if i.stream == promoted: remove_child(i)
		
	var audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.stream = bg_ambient
	audio_player.autoplay = true
	audio_player.play()	
		
		
	game_timer = 600.0
		
	#actual_time = Time.get_ticks_msec() / 1000
	#current_passed_time = _get_elapsed_time() 
	#print(current_passed_time)
	set_time = false
	game_started = false
	
	
	time_point = 0
#	_reset_email_data()
	game_over = false
	email_order.clear()
	child_order.clear()
	to_end_scene = false
	show_ui = false
	com_scene_instance = null
	assign_first_tasks = false
	set_emails_first = false
	assigned = false
	
	copied_file = null	
	hearts = 5
	
	shopping_open = false
	bin_open = false
	folder_open = false
	note_open = false
	game_open = false
	email_open = false
	
	
	#current_passed_time = Time.get_ticks_msec() / 1000
	current_scene = get_tree().get_current_scene().get_name()
	time_man_pos = Vector2(-370, 20)
	_set_cursor_design()
	
	files_ins = FileClass.new()
	email_ins = EmailClass.new()
	
	_set_file_data()
	
	total_tasks = email_ins.email_email.size() + email_ins.email_paper.size()
	
	for i in email_ins.email_email:
		i.fileName = files_ins.file[randi() % files_ins.file.size()].name
	
	for i in email_ins.email_email.size():
		_set_random_file()
	#print(email_ins.email_email)
	
	
	await get_tree().create_timer(timer).timeout
	assign_first_tasks = true
