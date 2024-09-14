extends Control


const mail_box_prefab = preload("res://Scene/email_item.tscn")
@onready var mail_container = $BG/ScrollContainer/VBoxContainer

#var set_first_five

var email_items = []
var set = false

func _ready():
	for i in GameManager.email_ins.email_email:
		var new_mail_box = mail_box_prefab.instantiate()
		mail_container.add_child(new_mail_box)
		new_mail_box.set_datas(i.isPaperWork, i.isActive,i.from, i.fileName, i.isDone, i.isFailed, i.profilePath)
		email_items.append(new_mail_box)
	for i in GameManager.email_ins.email_paper:
		var new_mail_box = mail_box_prefab.instantiate()
		mail_container.add_child(new_mail_box)
		new_mail_box.set_datas(i.isPaperWork, i.isActive,i.from, i.fileName, i.isDone, i.isFailed, i.profilePath)
		email_items.append(new_mail_box)
	for i in GameManager.email_ins.email_reply:
		var new_mail_box = mail_box_prefab.instantiate()
		mail_container.add_child(new_mail_box)
		new_mail_box.set_reply_datas(i.from, !i.isFailed, i.isActive, i.profilePath, i.withFile, i.isPaperWork)
		email_items.append(new_mail_box)
		
	#print(email_items)
	set = true
	
func _process(delta):
	# 3분 지나면 assign_first_tasks참으로 게임매니저에서 설정 -> 이메일 활성화도 게임 매니저에서?
#	if GameManager.assign_first_tasks && !set_first_five:
#		var count = 0
#		while count < 5:
#			var random = randi() % all_files.size()
#			if all_files[random].is_paper_work:
#				for j in GameManager.email_ins.email_paper:
#					if j.isActive: continue
#					else: 
#						j.isActive = t서rue
#						all_files[random].is_active = true
#						print(count)
#						count += 1
#						break
#				continue
#			else:
#				for j in GameManager.email_ins.email_email:
#					if j.isActive: continue
#					else: 
#						j.isActive = true
#						all_files[random].is_active = true
#						print(count)
#						count += 1
#						break
#				continue
#		print("--------------active")
#		set_first_five = true

	if set:
		for i in email_items:
			var item = null
			if i.is_paper_work:
				item = GameManager.get_item("paper", i.from_text.text)
			else:
				item = GameManager.get_item("email", i.from_text.text)
			
			if i.is_reply:
				item = GameManager.get_item("reply", i.from_text.text)
				
			if item.isActive && !i.is_set:
				print("set")
				_set_recent_email(i)
				i.is_active = true
				i.is_set = true

func get_reply(email):
	var timer = 1.0
	await get_tree().create_timer(timer).timeout
	var item = GameManager.get_item("reply", email.from_text.text)
	item.isActive = true
	#mail_container.add_child(new_mail_box)
	for i in email_items:
		if i.from_text.text == email.from_text.text && i.is_reply:
			i.is_active = true
			i.set_reply_datas(email.from_text.text, !email.is_failed, email.is_active, \
			email.profile_path, email.with_file, email.is_paper_work)
	#email_items.append(new_mail_box)

func _set_recent_email(email):
	print("set recent email")
	mail_container.remove_child(email)
	mail_container.add_child(email)
	# email item에서 자체적으로 active면 활성화
	#email.show()
	
#func set_visibility():
#	for i in GameManager.email_items:
#		for j in GameManager.email_ins.email_paper:
#			if j.fileName == i.file_name:
#				i.is_active = j.isActive

