class Files:
	var name : String
	var inBin : bool
	var image_path : String
	var parent : String
	var isFolder : bool


	func _init(name: String, inBin: bool, image_path: String, parent: String, isFolder: bool):
		self.name = name
		self.inBin = inBin
		self.image_path = image_path
		self.parent = parent
		self.isFolder = isFolder
			

var file:=[	
	Files.new("work", false, "res://Image/folder.png", "2024", true)
]
