extends Control

@onready var from_text
@onready var profile_icon
@onready var content_text
@onready var cover_panel
@onready var reply_btn
@onready var reply_w_file_btn

@onready var email_manager = get_node("/root/Computer/Manager/WindowGroup/EMailWindow")

var is_paper_work
var is_read
var is_active
var is_done
var is_failed

func _ready():
	self.hide()
	cover_panel.hide()

func set_datas(paper: bool, read: bool, active: bool, sender: String, file: String, done: bool, fail: bool):
	is_paper_work = paper
	is_read = read
	is_active = active
	from_text.text = sender
	is_done = done
	is_failed = fail
	
	content_text.text = "I hope this finds you well. I need " + file + " as soon as possible, please attach file as reply. Thank you."

func _process(delta):
	if is_active:
		self.show()
	
	if is_read:
		cover_panel.show()
	
	if is_done or is_failed:
		reply_btn.mouse_filter = MOUSE_FILTER_IGNORE
		reply_w_file_btn.mouse_filter = MOUSE_FILTER_IGNORE

func _on_reply_button_pressed():
	if not is_paper_work:
		for i in GameManager.email_ins.email_email:
			if i.from == from_text.text:
				i.isFailed = true
				is_failed = true
	else:
		# Paper work일 때 작업 완료 여부를 따져서 EmailManager의 set fail or success 호출
		pass

func _on_wf_reply_button_pressed():
	if is_paper_work:
		for i in GameManager.email_ins.email_paper:
			if i.from == from_text.text:
				i.isFailed = true
				is_failed = true
	else:
		# Email work일 때 작업 완료 여부를 따져서 EmailManager의 set fail or success 호출
		pass
