extends Control


var active_tasks = []
var timer = 30.0

@onready var email_manager = get_node("/root/Computer/Manager/WindowGroup/EMailWindow")

#func _process(delta):
#	if GameManager.assign_first_tasks && !GameManager.assigned:
#		# 초기 5개 활성화
#		for i in range(5):
#			_active_random_task()
#			print(GameManager.total_active_tasks)
#		#email_manager.set_visibility()
#		_repeat_activate()
#		GameManager.assigned = true
#
#func _repeat_activate():
#	while GameManager.total_active_tasks != GameManager.total_task:
#		await get_tree().create_timer(timer).timeout
#		_active_random_task()
#		print(GameManager.total_active_tasks)
#
#func _active_random_task():
#	var random_index = randi() % GameManager.total_task
#	var selected_file = email_manager.all_files[random_index]
#
#	if selected_file.is_active: _active_random_task()
#	else:
#		if selected_file.is_paper_work:
#			for j in GameManager.email_ins.email_paper:
#				if not j.isActive:
#					j.isActive = true
#					selected_file.is_active = true
#					GameManager.total_active_tasks += 1
#					break  # Task assigned, exit loop
#		else:
#			for j in GameManager.email_ins.email_email:
#				if not j.isActive:
#					j.isActive = true
#					selected_file.is_active = true
#					GameManager.total_active_tasks += 1
#					break  # Task assigned, exit loop
#		email_manager.get_new_email(selected_file)
