extends MarginContainer

@onready var bin_manager = $"../Manager/WindowGroup/BinWindow"
@onready var folder_manager = $"../Manager/WindowGroup/FolderWindow"
@onready var bin_sound = $"../BinSound"
@onready var click_sound = $"../ClickSound"
var clicked_item
var is_hover

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_copy_path_btn_pressed():
	click_sound.play()
	var item = GameManager.get_item("folder", GameManager.right_clicked_file)
	if !item.inBin:
		GameManager.copied_file = clicked_item
#	for i in GameManager.files_ins.file:
#		if i.name == GameManager.right_clicked_file:
#			if !i.inBin: 
#				# 해당 파일의 경로 가져오는 메서드 필요
#				GameManager.copied_file = folder_manager.get_file_path(i.name)
#			break
	self.hide()


func _on_delete_btn_pressed():
	click_sound.play()
	var item = GameManager.get_item("folder", GameManager.right_clicked_file)
	print(item.name)
	if item.inBin: 
		item.inBin = false  
		bin_manager.set_visibility()
		folder_manager.set_visibility()
	else:  
		bin_sound.play()
		item.inBin = true
		bin_manager.set_visibility()
		folder_manager.set_visibility()
#	for i in GameManager.files_ins.file:
#		if i.name == GameManager.right_clicked_file:
#			if i.inBin: 
#				i.inBin = false
#			else: 
#				i.inBin = true
#			bin_manager.set_visibility()
#			folder_manager.set_visibility()
#			break
	self.hide()


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and !is_hover:
			self.hide()

func _on_mouse_entered():
	is_hover = true

func _on_mouse_exited():
	is_hover = false
	
	
func _on_copy_path_btn_mouse_entered():
	is_hover = true

func _on_delete_btn_mouse_entered():
	is_hover = true
