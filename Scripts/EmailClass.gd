class Email:
	var from: String
	var isPaperWork: bool
	var fileName:String
	var isSet: bool
	var profilePath: String
	var isActive: bool
	var isFailed: bool
	var isDone: bool
	var isReply: bool
	var withFile: bool
	var isSent: bool
	var setScore: bool
  
	func _init(from: String, isPaperWork: bool, fileName: String, \
	profilePath: String, isActive: bool, isFailed: bool, isDone:bool, \
	isReply:bool, withFile: bool, isSent: bool, setScore: bool):
		self.from = from
		self.isPaperWork = isPaperWork
		self.fileName = fileName
		self.profilePath = profilePath
		self.isActive = isActive
		self.isFailed = isFailed
		self.isDone = isDone
		self.isReply = isReply
		self.withFile = withFile
		self.isSent = isSent
		self.setScore = setScore

# email task
var email_email:=[
	Email.new("Alex Johnson", false, "filename", "res://Image/profile_1.png", false, false, false, false, false, false, false),
	Email.new("Maria Rodriguez", false, "filename", "res://Image/profile_2.png", false, false, false, false, false, false, false),
	Email.new("Jordan Lee", false, "filename",  "res://Image/profile_3.png", false, false, false, false, false, false, false),
	Email.new("Emily Davis", false, "filename",  "res://Image/profile_4.png", false, false, false, false, false, false, false),
	Email.new("Michael Brown", false, "filename",  "res://Image/profile_5.png", false, false, false, false, false, false, false),
	Email.new("Olivia Martinez", false, "filename",  "res://Image/profile_6.png", false, false, false, false, false, false, false),
	Email.new("Daniel Wilson", false, "filename",  "res://Image/profile_7.png", false, false, false, false, false, false, false),
	Email.new("Sophia Anderson", false, "filename",  "res://Image/profile_8.png", false, false, false, false, false, false, false),
	Email.new("Ethan Thomas", false, "filename", "res://Image/profile_9.png", false, false, false, false, false, false, false),
	Email.new("Isabella White", false, "filename",  "res://Image/profile_10.png", false, false, false, false, false, false, false),
	Email.new("Benjamin Lewis", false, "filename", "res://Image/profile_11.png", false, false, false, false, false, false, false),
	Email.new("Ava Walker", false, "filename",  "res://Image/profile_12.png", false, false, false, false, false, false, false),
	Email.new("Mia Clark", false, "filename",  "res://Image/profile_13.png", false, false, false, false, false, false, false),
	Email.new("Lucas Young", false, "filename",  "res://Image/profile_14.png", false, false, false, false, false, false, false)
]
# paper task
var email_paper:=[
	Email.new("Louis Black", true, "none",  "res://Image/profile_15.png", false, false, false, false, false, false, false),
	Email.new("William Scott", true, "none",  "res://Image/profile_16.png", false, false, false, false, false, false, false),
	Email.new("Harper Allen", true, "none",  "res://Image/profile_17.png", false, false, false, false, false, false, false),
	Email.new("Chloe King", true, "none",  "res://Image/profile_18.png", false, false, false, false, false, false, false),
	Email.new("Henry Adams", true, "none",  "res://Image/profile_19.png", false, false, false, false, false, false, false)
]

var email_reply =[
	Email.new("Alex Johnson", false, "filename",  "res://Image/profile_1.png", false, false, false, true, false, false, false),
	Email.new("Maria Rodriguez", false, "filename",  "res://Image/profile_2.png", false, false, false, true, false, false, false),
	Email.new("Jordan Lee", false, "filename",  "res://Image/profile_3.png", false, false, false, true, false, false, false),
	Email.new("Emily Davis", false, "filename",  "res://Image/profile_4.png", false, false, false, true, false, false, false),
	Email.new("Michael Brown", false, "filename",  "res://Image/profile_5.png", false, false, false, true, false, false, false),
	Email.new("Olivia Martinez", false, "filename",  "res://Image/profile_6.png", false, false, false, true, false, false, false),
	Email.new("Daniel Wilson", false, "filename",  "res://Image/profile_7.png", false, false, false, true, false, false, false),
	Email.new("Sophia Anderson", false, "filename",  "res://Image/profile_8.png", false, false, false, true, false, false, false),
	Email.new("Ethan Thomas", false, "filename",  "res://Image/profile_9.png", false, false, false, true, false, false, false),
	Email.new("Isabella White", false, "filename",  "res://Image/profile_10.png", false, false, false, true, false, false, false),
	Email.new("Benjamin Lewis", false, "filename",  "res://Image/profile_11.png", false, false, false, true, false, false, false),
	Email.new("Ava Walker", false, "filename",  "res://Image/profile_12.png", false, false, false, true, false, false, false),
	Email.new("Mia Clark", false, "filename",  "res://Image/profile_13.png", false, false, false, true, false, false, false),
	Email.new("Lucas Young", false, "filename",  "res://Image/profile_14.png", false, false, false, true, false, false, false),
	Email.new("Louis Black", true, "none",  "res://Image/profile_15.png", false, false, false, true, false, false, false),
	Email.new("William Scott", true, "none",  "res://Image/profile_16.png", false, false, false, true, false, false, false),
	Email.new("Harper Allen", true, "none",  "res://Image/profile_17.png", false, false, false, true, false, false, false),
	Email.new("Chloe King", true, "none",  "res://Image/profile_18.png", false, false, false, true, false, false, false),
	Email.new("Henry Adams", true, "none",  "res://Image/profile_19.png", false, false, false, true, false, false, false)
]
