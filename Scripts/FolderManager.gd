extends Control

@onready var path_text = "$."
# 컨테이너 부모
@onready var container_parent = "$."
# 폴더들 정렬시킬 컨테이너
@onready var grid_container = "$."
# 폴더나 아이템 프리팹 
@onready var item_prefab = "$."

var current_folder
var previous_folder

var folde_order = []

func _ready():
	for i in GameManager.data_class_ins.data:
		var item_ins = item_prefab.instance()

		var item_img = item_ins.get_node("image")
		var item_btn = item_ins.get_node("button")
		var item_name = item_ins.get_node("name")

		item_img.texture = load(i.image_path)
		item_name.text = i.name
		item_btn.connect("pressed", self, "_on_button_pressed", [i.name, i.isFolder])
	
		grid_container.add(item_ins)
		if !i.inBin:
			item_ins.hide()
		else: item_ins.show()

	path_text.text = "Destktop"
	current_folder = "default"
	previous_folder = "none"
	folder_order.append(current_folder.text)
		

# 폴더의 삭제나 복구 작업 시(inBin의 변경) 호출
func _set_visibility():
	for i in GameManager.data_class._ins.data:
		if !i.inBin:
			item_ins.hide()
		else: item_ins.show()

# 폴더 눌러서 윈도우 띄우기
func _add_window(parent_folder):
	var grid_container_ins = gird_container.instance()
	grid_parent.add(grid_container_ins)

	for i in GameManager.data_class_ins.data:
		# 선택한 폴더의 내부를 보여주는 것으로 해당 폴더를 부모로 가진 데이터들만 가져오기
		if (i.parent == parent_folder):
			var item_ins = item_prefab.instance()
	
			var item_img = item_ins.get_node("image")
			var item_btn = item_ins.get_node("button")
			var item_name = item_ins.get_node("name")

			item_img.texture = load(i.image_path)
			img_name.text = i.name
			item_btn.connect("pressed", self, "_on_button_pressed", [i.name])
		
			grid_container_ins.add(item_ins)
			if !i.inBin:
				item_ins.hide()
			else: item_ins.show()

	path_text += ("\\" + parent_folder)
	previous_folder = current_folder
	current_folder = parent_folder
	folder_order.append(current_folder.text)

# 뒤로가기 눌러서 해당 윈도우 제거
func _remove_window():
	var last_child = grid_parent.get_child(child_count - 1)
	grid_parent.remove_child(last_child)
	path.text = _remove_last_word_and_slash(path.text)
	current_folder = previous_folder
	folder_order.append(current_folder.text)
	previous_folder = folder_order[folder_order.size()-2]
	

func _remove_last_word_and_slash(text: String) -> String:
	var parts = text.split(" \\ ")
	if parts.size() > 1:
		# 마지막 단어를 삭제하기 위해 배열의 마지막 요소를 제거합니다.
		parts.pop_back()
		# 나머지 부분을 다시 결합합니다.
		return " \\ ".join(parts)
	else:
		# "\"로 구분된 부분이 없으면 원래 텍스트를 반환합니다.
		return text
	

func _on_button_pressed(name, is_folder):
	if is_folder:
		_add_window(name)
