class Email:
	var from: String
	var isPaperWork: bool
	var fileName:String
	var isRead: bool
	var profilePath: String
	var isActive: bool
	var isFailed: bool
	var isDone: bool
  
	func _init(from: String, isPaperWork: bool, fileName: String, isRead: bool, profilePath: String, isActive: bool, isFailed: bool, isDOne:bool):
		self.from = from
		self.isPaperWork = isPaperWork
		self.fileName = fileName
		self.isRead = isRead
		self.profilePath = profilePath
		self.isActive = isActive
		self.isFailed = isFailed
		self.isDone = isDone
	
	
# email task
var email_email:=[
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_1.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_2.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_3.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_4.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_5.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_6.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_7.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_8.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_9.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_10.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_11.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_12.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_13.png", false, false, false),
	Email.new("Simon Smith", false, "filename", false, "res://Image/profile_14.png", false, false, false)
]
# paper task
var email_paper:=[
	Email.new("Louis Black", true, "none", false, "res://Image/profile_15.png", false, false, false),
	Email.new("Jack Conner", true, "none", false, "res://Image/profile_16.png", false, false, false),
	Email.new("name", true, "none", false, "res://Image/profile_17.png", false, false, false),
	Email.new("name", true, "none", false, "res://Image/profile_18.png", false, false, false),
	Email.new("name", true, "none", false, "res://Image/profile_19.png", false, false, false)
]
