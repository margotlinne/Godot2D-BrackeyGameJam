extends Control

@onready var window_group = $"../WindowGroup"

@onready var bin_window = $"../WindowGroup/BinWindow"
@onready var shopping_window = $"../WindowGroup/ShoppingWebWindow"
@onready var email_window = $"../WindowGroup/EMailWindow"
@onready var game_window = $"../WindowGroup/GameWindow"
@onready var folder_window = $"../WindowGroup/FolderWindow"
@onready var note_window = $"../WindowGroup/NoteWindow"

@onready var bin_active = $TaskBar/HBoxContainer/BinApp/Panel
@onready var shopping_active = $TaskBar/HBoxContainer/InternetApp/Panel
@onready var email_active = $TaskBar/HBoxContainer/EmailApp/Panel
@onready var game_active = $TaskBar/HBoxContainer/CardGame/Panel
@onready var folder_active = $TaskBar/HBoxContainer/Folders/Panel
@onready var note_active = $TaskBar/HBoxContainer/Note/Panel

@onready var bin_btn = $TaskBar/HBoxContainer/BinApp
@onready var shopping_btn = $TaskBar/HBoxContainer/InternetApp
@onready var email_btn = $TaskBar/HBoxContainer/EmailApp
@onready var game_btn = $TaskBar/HBoxContainer/CardGame
@onready var folder_btn = $TaskBar/HBoxContainer/Folders
@onready var note_btn = $TaskBar/HBoxContainer/Note

@onready var email_notification = $TaskBar/HBoxContainer/EmailApp/Notification

@onready var click_sound = $"../../ClickSound"

var front_window

var btns = []

# Called when the node enters the scene tree for the first time.
func _ready():		
	btns.append(bin_btn)
	btns.append(shopping_btn)
	btns.append(email_btn)
	btns.append(game_btn)
	btns.append(folder_btn)
	btns.append(note_btn)
	
	
	# sort windows order
	if (GameManager.child_order.size() != 0):
		for i in GameManager.child_order:
			_set_as_last_child(_find_window(i))		
	else: 
		GameManager.child_order.append("BinWindow")
		GameManager.child_order.append("ShoppingWebWindow")
		GameManager.child_order.append("EMailWindow")
		GameManager.child_order.append("GameWindow")
		GameManager.child_order.append("FolderWindow")
		GameManager.child_order.append("NoteWindow")
		GameManager.bin_closed = true
		GameManager.game_closed = true
		GameManager.note_closed = true
		GameManager.email_closed = true
		GameManager.folder_closed = true
		GameManager.shopping_closed = true
		
		GameManager.bin_open = false
		GameManager.game_open = false
		GameManager.note_open = false
		GameManager.email_open = false
		GameManager.folder_open = false
		GameManager.shopping_open = false
	
	
			
	if GameManager.bin_open: 
		bin_window.show()
		bin_active.show()
	else: 
		_deactive_btn_style(bin_btn)		
		bin_window.hide()
		if "BinWindow" not in GameManager.active_windows: bin_active.hide()
		else: bin_active.show()
	
	if GameManager.shopping_open: 
		shopping_window.show()
		shopping_active.show()
	else: 
		_deactive_btn_style(shopping_btn)
		shopping_window.hide()
		if "ShoppingWebWindow" not in GameManager.active_windows: shopping_active.hide()
		else: shopping_active.show()
	
	if GameManager.email_open: 
		email_window.show()
		email_active.show()
	else: 
		_deactive_btn_style(email_btn)
		email_window.hide()
		if "EMailWindow" not in GameManager.active_windows: email_active.hide()
		else: email_active.show()
	
	if GameManager.game_open: 
		game_window.show()
		game_active.show()
	else: 
		_deactive_btn_style(game_btn)
		game_window.hide()
		if "GameWindow" not in GameManager.active_windows: game_active.hide()
		else: game_active.show()
	
	if GameManager.folder_open: 
		folder_window.show()
		folder_active.show()
	else: 
		_deactive_btn_style(folder_btn)
		folder_window.hide()
		if "FolderWindow" not in GameManager.active_windows: folder_active.hide()
		else: folder_active.show()
	
	if GameManager.note_open: 
		note_window.show()
		note_active.show()
	else: 
		_deactive_btn_style(note_btn)
		note_window.hide()
		if "NoteWindow" not in GameManager.active_windows: note_active.hide()
		else: note_active.show()
	
	if GameManager.game_over:
		#print("game over")
		_hide_everything()
		
	if "EMailWindow" not in GameManager.active_windows and GameManager.got_new_email:
		email_notification.show()
	elif "EMailWindow" in GameManager.active_windows and GameManager.got_new_email:
		email_notification.hide()
		
		
func _process(delta):
#	if not game_window.visible:
#		GameManager.current_card = -1
#		GameManager.previous_card = -1
	if GameManager.game_over:
		#print("game over")
		_hide_everything()
		
	if !email_window.visible && GameManager.got_new_email:
		email_notification.show()
	elif email_window.visible && GameManager.got_new_email:
		email_notification.hide()
		GameManager.got_new_email = false
	
func _hide_everything():
	bin_window.hide()
	bin_active.hide()
	_deactive_btn_style(bin_btn)
	shopping_window.hide()
	shopping_active.hide()
	_deactive_btn_style(shopping_btn)
	game_window.hide()
	game_active.hide()
	_deactive_btn_style(game_btn)
	email_window.hide()
	email_active.hide()
	_deactive_btn_style(email_btn)
	note_window.hide()
	note_active.hide()
	_deactive_btn_style(note_btn)
	folder_window.hide()
	folder_active.hide()
	_deactive_btn_style(folder_btn)
	
	
func _find_window(name: String):
	if name == "BinWindow": return bin_window
	elif name == "EMailWindow": return email_window
	elif name == "FolderWindow": return folder_window
	elif name == "GameWindow": return game_window
	elif name == "NoteWindow": return note_window
	elif name == "ShoppingWebWindow": return shopping_window
	
func _save_order():
	#print("======================================")
	GameManager.child_order.clear()
	for child in window_group.get_children():
		GameManager.child_order.append(child.name)
		#print(child)
	# 업데이트된 순서로 "front_window" 설정
	_find_front_window()
	_set_btn_style()
	#print("가장 앞의 윈도우는: ", front_window)
		
func _set_btn_style():
	if front_window == bin_window.to_string(): 
		_active_btn_style(bin_btn)
	elif front_window == shopping_window.to_string():
		_active_btn_style(shopping_btn)
	elif front_window == email_window.to_string():
		_active_btn_style(email_btn)
	elif front_window == game_window.to_string():
		_active_btn_style(game_btn)
	elif front_window == folder_window.to_string():
		_active_btn_style(folder_btn)
	elif front_window == note_window.to_string():
		_active_btn_style(note_btn)
	else:
		_deactive_btn_style(bin_btn)
		_deactive_btn_style(shopping_btn)
		_deactive_btn_style(email_btn)
		_deactive_btn_style(game_btn)
		_deactive_btn_style(folder_btn)
		_deactive_btn_style(note_btn)

# 가장 최근에 추가된 즉 맨 앞에 있는 윈도우가 뭔지 확인
func _find_front_window():
	#print("이동 후:", GameManager.child_order)
	#print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
#	for i in GameManager.child_order:
#		print(i)
#		if _find_window(i).visible: 
#			front_window = _find_window(i).to_string()
#			break
#		elif i == GameManager.child_order[GameManager.child_order.size() - 1]:
#			front_window = "none"
#			break
			
	for i in range(GameManager.child_order.size() - 1, -1, -1):
		#print(_find_window(GameManager.child_order[i]))
		if _find_window(GameManager.child_order[i]).visible: 
			front_window = _find_window(GameManager.child_order[i]).to_string()
			break
		elif i == 0:
			front_window = "none"
			break
	#print("found: ", front_window)

func _set_as_last_child(window: Node):
	if window in window_group.get_children():  # 자식 목록에서 노드 확인
		window_group.remove_child(window)  # 기존 위치에서 제거
		window_group.add_child(window)  # 마지막 위치에 추가
	#front_window = window.to_string()

	
func _set_as_first_child(window: Node):
	#print(GameManager.child_order)
	#print("호출")
	# 먼저 자식 노드들을 제거
	var nodes_to_remove = []
	for name in GameManager.child_order:
		var node = _find_window(name)
		if node and node != window:
			if node.get_parent() == window_group:
				nodes_to_remove.append(node)
	
	# 제거할 노드들을 실제로 제거
	for node in nodes_to_remove:
		window_group.remove_child(node)

	# 현재 노드를 첫 번째 자식으로 추가
	window_group.add_child(window)
	
	# 나머지 노드들을 다시 추가
	for name in GameManager.child_order:
		var node = _find_window(name)
		if node and node != window:
			#print("add::::", node)
			window_group.add_child(node)
			
	
	
func _active_btn_style(btn):
	for i in btns:
		if i == btn:
			btn.get_theme_stylebox("normal").bg_color.a = 0.5
		else: 
			i.get_theme_stylebox("normal").bg_color.a = 0
func _deactive_btn_style(btn):
	btn.get_theme_stylebox("normal").bg_color.a = 0	
	
	
# task bar app btn -------------------------------------------------------------	
func _on_bin_app_pressed():
	click_sound.play()
	
	if bin_window.visible:
		if front_window != bin_window.to_string():
			_set_as_last_child(bin_window)
			GameManager.bin_open = true
		else: 
			_set_as_first_child(bin_window)
			GameManager.bin_open = false
			bin_window.hide()
	else:
		_set_as_last_child(bin_window)		
		bin_active.show()
		bin_window.show()
		GameManager.bin_open = true		
		
		if "BinWindow" not in GameManager.active_windows:
			GameManager.active_windows.append("BinWindow")
	_save_order()
	
	
func _on_internet_app_pressed():
	click_sound.play()
	
	if shopping_window.visible:
		if front_window != shopping_window.to_string():
			_set_as_last_child(shopping_window)
			GameManager.shopping_open = true
		else: 
			_set_as_first_child(shopping_window)
			GameManager.shopping_open = false
			shopping_window.hide()
	else:
		_set_as_last_child(shopping_window)		
		shopping_active.show()
		shopping_window.show()
		GameManager.shopping_open = true	
		
		if "ShoppingWebWindow" not in GameManager.active_windows:
			GameManager.active_windows.append("ShoppingWebWindow")
	_save_order()


func _on_email_app_pressed():
	click_sound.play()
	
	if email_window.visible:
		if front_window != email_window.to_string():
			_set_as_last_child(email_window)
			GameManager.email_open = true
		else: 
			_set_as_first_child(email_window)
			GameManager.email_open = false
			email_window.hide()
	else:
		_set_as_last_child(email_window)
		email_active.show()
		email_window.show()
		GameManager.email_open = true
		
		if "EMailWindow" not in GameManager.active_windows:
			GameManager.active_windows.append("EMailWindow")
	_save_order()

func _on_card_game_pressed():
	click_sound.play()
	
	if game_window.visible:
		if front_window != game_window.to_string():
			_set_as_last_child(game_window)
			GameManager.game_open = true
		else: 
			_set_as_first_child(game_window)
			game_window.hide()
			GameManager.game_open = false
	else:
		_set_as_last_child(game_window)
		game_active.show()
		game_window.show()
		GameManager.game_open = true
		
		if "GameWindow" not in GameManager.active_windows:
			GameManager.active_windows.append("GameWindow")
	_save_order()

func _on_folders_pressed():
	click_sound.play()
	
	if folder_window.visible:
		if front_window != folder_window.to_string():
			_set_as_last_child(folder_window)
			GameManager.folder_open = true
		else: 
			_set_as_first_child(folder_window)
			folder_window.hide()
			GameManager.folder_open = false
	else:
		_set_as_last_child(folder_window)
		folder_active.show()
		folder_window.show()
		GameManager.folder_open = true
		
		if "FolderWindow" not in GameManager.active_windows:
			GameManager.active_windows.append("FolderWindow")
	_save_order()


func _on_note_pressed():
	click_sound.play()
	
	if note_window.visible:
		if front_window != note_window.to_string():
			_set_as_last_child(note_window)
			GameManager.note_open = true
		else: 
			_set_as_first_child(note_window)
			note_window.hide()
			GameManager.note_open = false
	else:
		_set_as_last_child(note_window)
		note_active.show()
		note_window.show()
		GameManager.note_open = true
		
		if "NoteWindow" not in GameManager.active_windows:
			GameManager.active_windows.append("NoteWindow")
	_save_order()




# close / exit btn -------------------------------------------------------------

func _on_close_btn_bin_pressed():
	GameManager.bin_closed = false
	click_sound.play()
	
	bin_window.hide()
	_deactive_btn_style(bin_btn)
	_set_as_first_child(bin_window)
	_save_order()
	GameManager.bin_open = false
func _on_exit_btn_bin_pressed():
	GameManager.bin_closed = true
	click_sound.play()
	
	bin_active.hide()
	bin_window.hide()
	_deactive_btn_style(bin_btn)
	_set_as_first_child(bin_window)
	_save_order()
	GameManager.bin_open = false
	
	for i in range(GameManager.active_windows.size()):
		if GameManager.active_windows[i] == "BinWindow":
			GameManager.active_windows.remove_at(i)
	
	
	
	


func _on_close_btn_shopping_pressed():
	GameManager.shopping_closed = false
	click_sound.play()
	
	shopping_window.hide()
	_deactive_btn_style(shopping_btn)
	_set_as_first_child(shopping_window)
	_save_order()
	GameManager.shopping_open = false
func _on_exit_btn_shopping_pressed():
	GameManager.shopping_closed = true
	click_sound.play()
	
	shopping_active.hide()
	shopping_window.hide()
	_deactive_btn_style(shopping_btn)
	_set_as_first_child(shopping_window)
	_save_order()
	GameManager.shopping_open = false
	
	for i in range(GameManager.active_windows.size()):
		if GameManager.active_windows[i] == "ShoppingWebWindow":
			GameManager.active_windows.remove_at(i)


func _on_close_btn_email_pressed():
	GameManager.email_closed = false
	click_sound.play()
	
	email_window.hide()
	_deactive_btn_style(email_btn)
	_set_as_first_child(email_window)
	_save_order()
	GameManager.email_open = false
func _on_exit_btn_email_pressed():
	GameManager.email_closed = true
	click_sound.play()
	
	email_active.hide()
	email_window.hide()
	_deactive_btn_style(email_btn)
	_set_as_first_child(email_window)
	_save_order()
	GameManager.email_open = false

	for i in range(GameManager.active_windows.size()):
		if GameManager.active_windows[i] == "EMailWindow":
			GameManager.active_windows.remove_at(i)	

func _on_close_btn_game_pressed():
	GameManager.game_closed = false
	click_sound.play()
	
	game_window.hide()
	_deactive_btn_style(game_btn)
	_set_as_first_child(game_window)
	_save_order()
	GameManager.game_open = false
	
func _on_exit_btn_game_pressed():
	GameManager.game_closed = true
	click_sound.play()
	
	game_active.hide()
	game_window.hide()
	_deactive_btn_style(game_btn)
	_set_as_first_child(game_window)
	_save_order()
	GameManager.game_open = false
	for i in range(GameManager.active_windows.size()):
		if GameManager.active_windows[i] == "GameWindow":
			GameManager.active_windows.remove_at(i)
			GameManager.game_started = false

func _on_close_btn_folder_pressed():
	GameManager.folder_closed = false
	click_sound.play()
	
	folder_window.hide()
	_deactive_btn_style(folder_btn)
	_set_as_first_child(folder_window)
	_save_order()
	GameManager.folder_open = false
func _on_exit_btn_folder_pressed():
	GameManager.folder_closed = true
	click_sound.play()
	
	folder_active.hide()
	folder_window.hide()
	_deactive_btn_style(folder_btn)
	_set_as_first_child(folder_window)
	_save_order()
	GameManager.folder_open = false

	for i in range(GameManager.active_windows.size()):
		if GameManager.active_windows[i] == "FolderWindow":
			GameManager.active_windows.remove_at(i)


func _on_close_btn_note_pressed():
	GameManager.note_closed = false
	click_sound.play()
	
	note_window.hide()
	_deactive_btn_style(note_btn)
	_set_as_first_child(note_window)
	_save_order()
	GameManager.note_open = false
func _on_exit_btn_note_pressed():
	GameManager.note_closed = true
	click_sound.play()
	
	note_active.hide()
	note_window.hide()
	_deactive_btn_style(note_btn)
	_set_as_first_child(note_window)
	_save_order()
	GameManager.note_open = false
	
	for i in range(GameManager.active_windows.size()):
		if GameManager.active_windows[i] == "NoteWindow":
			GameManager.active_windows.remove_at(i)
