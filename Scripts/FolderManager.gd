extends Control

@onready var path_text = $Window/Label
# 컨테이너 부모
@onready var container_parent = $Window/ScrollContainer/ParentContainer
# 폴더들 정렬시킬 컨테이너
const item_group = preload("res://Scene/item_group.tscn")
# 폴더나 아이템 프리팹 
const item_prefab = preload("res://Scene/item.tscn")

@onready var default_item_group = $Window/ScrollContainer/ParentContainer/ItemGroup

@onready var back_btn = $Window/ScrollContainer/ParentContainer/BackBtn

var current_folder
var previous_folder

var folder_order = []

var all_files = []

var path_items = []

func _ready():
	var default_grid_container = default_item_group.get_node("GridContainer")
	for i in GameManager.files_ins.file:
		if i.parent == "none":
			var item_ins = item_prefab.instantiate()
			#item_ins.get_script().set_datas(i.name, i.isFolder)
			default_grid_container.add_child(item_ins)
			item_ins.set_datas(i.name, i.isFolder, i.inBin)
			all_files.append(item_ins)
			if !i.inBin:
				item_ins.show()
			else: item_ins.hide()
		

	path_text.text = "Work"
	current_folder = "default"
	previous_folder = "none"
	folder_order.append(current_folder)
	
	
func _process(delta):
	if current_folder == "default": 
		back_btn.hide()
	else: 
		back_btn.show()

# 폴더의 삭제나 복구 작업 시(inBin의 변경) 호출
func _set_visibility():
	for i in GameManager.files_ins.file:
		if !i.inBin:
	#		item_ins.hide()
		#else: item_ins.show()
			pass
			
			
func _set_btn_front():
	container_parent.remove_child(back_btn)
	container_parent.add_child(back_btn)			

# 폴더 눌러서 윈도우 띄우기
func add_window(parent_folder):	
	var item_group_ins = item_group.instantiate()
	container_parent.add_child(item_group_ins)
	var grid_container = item_group_ins.get_node("GridContainer")

	for i in GameManager.files_ins.file:
		# 선택한 폴더의 내부를 보여주는 것으로 해당 폴더를 부모로 가진 데이터들만 가져오기
		if i.parent == parent_folder:
			var item_ins = item_prefab.instantiate()
			grid_container.add_child(item_ins)
			item_ins.set_datas(i.name, i.isFolder, i.inBin)
			if !i.inBin:
				item_ins.show()
			else: item_ins.hide()

	previous_folder = current_folder
	current_folder = parent_folder
	folder_order.append(current_folder)
	print(folder_order)
	
	_set_path()
	_set_btn_front()
	print(container_parent.get_children())

# 뒤로가기 눌러서 해당 윈도우 제거
func _remove_window():
	print("back")
	var last_child = container_parent.get_child(container_parent.get_child_count() - 2)
	container_parent.remove_child(last_child)
	last_child.queue_free()
	
	if folder_order.size() > 2:
		current_folder = folder_order[folder_order.size() - 2]
		previous_folder = folder_order[folder_order.size() - 3]
	else:
		current_folder = folder_order[0]
		previous_folder = "none"
		
	
	folder_order.remove_at(folder_order.size() - 1)
			
		
	
	
	_set_path()
#	print("previous: ", previous_folder, "/ current: ", current_folder)
#	current_folder = previous_folder
#	folder_order.append(current_folder)
#	if folder_order.size() > 2:
#		previous_folder = folder_order[folder_order.size()-2]
#	else: previous_folder = "none"
#	print("previous: ", previous_folder, "/ current: ", current_folder)
	print(folder_order)
	
	

func _set_path():
	var path_string = "Work"
	for i in folder_order:
		if i != "default":
			path_string += ("\\" + i) 
	
	path_text.text = path_string
	
func get_file_path(folder_name):
	var path = "Work\\"	
	path_items.clear()
	path_items.append(folder_name)	
	_get_parent(folder_name)	
	for i in range(path_items.size()-1, -1, -1):
		path += path_items[i]
		if i != 0: path += "\\"
	return path


func _get_parent(folder_name):
	for i in GameManager.files_ins.file:
		if i.name == folder_name:
			for j in GameManager.files_ins.file:
				if i.parent == j.name:
					path_items.append(i.parent)
					_get_parent(i.parent)
				if j == GameManager.files_ins.file[GameManager.files_ins.file.size() - 1] and j.parent == "none":
					return



func set_visibility():
	for i in all_files:
		for j in GameManager.files_ins.file:
			if j.name == i.its_name:
				i.in_bin = j.inBin
				if i.in_bin: i.hide()
				else: i.show()


# back btn
func _on_back_btn_pressed():
	_remove_window()
