class Email_task:
	var from : String
	var folder_name : String
	var is_correct : bool
	var is_submitted : bool
	
	func _init(from: String, folder_name: String, is_correct: bool, is_submitted: bool):
		self.from = from
		self.folder_name = folder_name
		self.is_correct = is_correct
		self.is_submitted = is_submitted
		
var email_task := [
	# 총 게임 내에 존재할 이메일 태스크들 쭉 나열 > 여기서 랜덤하게 태스크로 나감
]
