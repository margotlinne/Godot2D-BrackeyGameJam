extends Control

var active_tasks = []
var timer = 30.0

@onready var email_manager = get_node("/root/Computer/Manager/WindowGroup/EMailWindow")

func _process(delta):
	if not GameManager.assign_first_tasks:
		# 초기 5개 활성화
		for i in range(5):
			_active_random_task()
		email_manager.set_visibility()
		_repeat_activate()
		GameManager.assign_first_tasks = true

func _repeat_activate():
	while GameManager.total_active_task != email_manager.all_files.size():
		await get_tree().create_timer(timer).timeout
		_active_random_task()

func _active_random_task():
	var random_index = randi() % email_manager.all_files.size()
	var selected_file = email_manager.all_files[random_index]

	if selected_file.is_paper_work:
		for j in GameManager.email_ins.email_paper:
			if not j.isActive:
				j.isActive = true
				selected_file.is_active = true
				GameManager.total_active_tasks += 1
				break  # Task assigned, exit loop
	else:
		for j in GameManager.email_ins.email_email:
			if not j.isActive:
				j.isActive = true
				selected_file.is_active = true
				GameManager.total_active_tasks += 1
				break  # Task assigned, exit loop
