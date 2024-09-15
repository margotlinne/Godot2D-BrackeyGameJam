extends VBoxContainer

@onready var name_text = $Control/Label
@onready var icon = $Icon
@onready var btn = $Icon/Button

var folder_icon = preload("res://Image/folder_full_icon.png")
var empty_folder_icon = preload("res://Image/folder_icon.png")
var file_icon = preload("res://Image/file_icon.png")

var its_name: String
var is_folder: bool
var in_bin: bool
var data_set = false
var is_hover: bool

@onready var folder_manager = get_node("/root/Computer/Manager/WindowGroup/FolderWindow")
@onready var right_click_window = get_node("/root/Computer/RightClickWindow")
@onready var click_sound = get_node("/root/Computer/ClickSound")
	
func set_datas(title, check, bin):
	#print("called")
	its_name = title
	is_folder = check
	in_bin = bin
	
	name_text.text = its_name
	# 폴더 여부에 따라 폴더/파일 이미지 설정
	if is_folder: icon.texture = folder_icon
	else: icon.texture = file_icon
	
	data_set = true
	
func _process(delta):
	if data_set: _set_icon()
	
	
func _set_icon():
	var child = []
	if is_folder:
		for i in GameManager.files_ins.file:
			if i.parent == its_name and !i.inBin:
				child.append(i)
				
		if child.size() == 0:
			icon.texture = empty_folder_icon
		else:	icon.texture = folder_icon
	
	
func get_bin_bool(bin):
	in_bin = bin
	
func _on_button_pressed():
	click_sound.play()
	if data_set && is_folder && !in_bin:
		folder_manager.add_window(its_name)


func _on_button_mouse_entered():
	is_hover = true
func _on_button_mouse_exited():
	is_hover = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and is_hover:
			set_right_click_window(event.position, in_bin, self)
			GameManager.right_clicked_file = its_name
			#print("Right mouse button clicked")

func set_right_click_window(pos, bin, file):
	click_sound.play()
	var copy_path_label1 = right_click_window.get_node("MarginContainer/VBoxContainer/Label")
	var delete_btn =  right_click_window.get_node("MarginContainer/VBoxContainer/DeleteBtn")
	var copy_path_btn = copy_path_label1.get_node("CopyPathBtn")
	var copy_path_label2 = copy_path_btn.get_node("Label")
	right_click_window.show()
	right_click_window.set_position(pos)
	right_click_window.clicked_item = self
	
	if bin == true:
		copy_path_btn.mouse_filter = MOUSE_FILTER_IGNORE
		var theme = Theme.new()
		theme.set("font_color", Color.DIM_GRAY)		
		copy_path_btn.add_theme_color_override("font_color", Color.DIM_GRAY)
		copy_path_btn.theme = theme
		copy_path_btn.text = ""
		copy_path_label1.text = folder_manager.get_file_path(its_name)
		copy_path_label2.text = copy_path_label1.text
		delete_btn.text = "Restore"
	else:
		copy_path_btn.mouse_filter = MOUSE_FILTER_STOP
		var theme = Theme.new()
		theme.set("font_color", Color.WHITE)
		copy_path_btn.add_theme_color_override("font_color", Color.WHITE)
		copy_path_btn.theme = theme
		copy_path_btn.text = "Copy Path"
		copy_path_label1.text = ""
		copy_path_label2.text = ""
		delete_btn.text = "Delete"

