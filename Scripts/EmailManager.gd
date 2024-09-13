extends Control


@onready var mail_box_prefab
@onready var mail_container

var set_first_five

var all_files = []

func _ready():
	for i in GameManager.email_ins.email_email:
		var new_mail_box = mail_box_prefab.instantiate()
		new_mail_box.set_datas(i.isPaperWork, i.isRead, i.isActive,i.from, i.fileName, i.isDone, i.isFailed)
		all_files.append(new_mail_box)
	for i in GameManager.email_ins.email_paper:
		var new_mail_box = mail_box_prefab.instantiate()
		new_mail_box.set_datas(i.isPaperWork, i.isRead, i.isActive,i.from, i.fileName, i.isDone, i.isFailed)
		all_files.append(new_mail_box)


func _process(delta):
	# 3분 지나면 assign_first_tasks참으로 게임매니저에서 설정
	if GameManager.assign_first_tasks && !set_first_five:
		var count = 0
		while count <5:
			var random = randi() % all_files.size()
			if all_files[random].is_paper_work:
				for j in GameManager.email_ins.email_paper:
					if j.isActive: continue
					else: 
						j.isActive = true
						all_files[random].is_active = true
						count += 1
						continue
			else:
				for j in GameManager.email_ins.email_email:
					if j.isActive: continue
					else: 
						j.isActive = true
						all_files[random].is_active = true
						count += 1
						continue
		set_first_five = true

func set_visibility():
	for i in all_files:
		for j in GameManager.email_ins.email_paper:
			if j.from == i.from:
				i.is_active = j.isActive
			
func set_fail_or_success(paper: bool):
	# 페이퍼 태스크일 때
	if paper:
		pass
	# 이메일 태스크일 때
	else:
		pass
