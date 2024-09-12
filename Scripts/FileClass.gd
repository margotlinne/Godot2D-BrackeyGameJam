class Files:
	var name : String
	var inBin : bool
	var parent : String
	var isFolder : bool


	func _init(name: String, inBin: bool, parent: String, isFolder: bool):
		self.name = name
		self.inBin = inBin
		self.parent = parent
		self.isFolder = isFolder
			

var file:=[	
	Files.new("Python", false, "none", true),
	Files.new("C", false, "none", true),
	Files.new("HTML", false, "none", true),
	
	Files.new("Designs", false, "none", true),
	Files.new("HandDrawn", false, "Designs", true),
	Files.new("Illustration", false, "Designs", true),
	Files.new("Photo", false, "Designs", true),
	
	
	Files.new("company_icon.png", true, "HandDrawn", false),
	Files.new("company_logo.png", false, "HandDrawn", false),
	Files.new("company_stamp.jpg", false, "Photo", false),
	Files.new("company_cellebration.jpg", false, "Photo", false)
]
