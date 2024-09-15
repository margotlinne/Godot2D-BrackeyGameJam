extends Control

const card_prefab = preload("res://Scene/card.tscn")

@onready var start_btn = $BG/StartGameBtn
@onready var game_canvas = $BG/GameCanvas
@onready var card_pos = $BG/GameCanvas/CardPos
@onready var game_over_canvas = $BG/GameOverCanvas
@onready var game_window = $"."

@onready var score_text = $BG/GameCanvas/ScoreTxt

@onready var click_sound = $"../../../ClickSound"
@onready var game_success_sound = $"../../../GameSuccess"
@onready var game_fail_sound = $"../../../GameFail"
@onready var card_sound = $"../../../FlipCard"

var spawn_card
var game_started

var previous_card_num
var new_card_num

var score = 0

var reseted = false

func _ready():
	# 창을 띄워놓은 게 아니라면 새 게임 시작
	if "GameWindow" not in GameManager.active_windows || !GameManager.card_started:
		print("resetttttt")
		previous_card_num = -1
		new_card_num  = -1
		game_canvas.hide()
		game_over_canvas.hide()
		spawn_card = false
		score = 0
	elif "GameWindow" in GameManager.active_windows:
		start_btn.hide()
		game_canvas.show()
		if GameManager.card_failed:
			game_over_canvas.show()
		else:
			game_over_canvas.hide()
		_get_card(GameManager.current_card, GameManager.card_color, GameManager.card_icon)
		previous_card_num = GameManager.previous_card
		new_card_num = GameManager.current_card
	
	print(GameManager.current_score)
	score_text.text = "Score: " + str(GameManager.current_score) + "\nHigh Score: " + str(GameManager.card_high_score)
	
	
	
	

func _process(delta):
	#print(GameManager.current_score)
	score_text.text = "Score: " + str(GameManager.current_score) + "\nHigh Score: " + str(GameManager.card_high_score)
	
	if "GameWindow" not in GameManager.active_windows && !reseted:
		_reset_game()
		reseted = true
	
	if game_started && !spawn_card:
		_get_random_card()
		spawn_card = true
		
	if game_over_canvas.visible:
		if score > GameManager.card_high_score:
			GameManager.card_high_score = score

func _reset_game():
	score = 0
	spawn_card = false
	_remove_previous_card()
	start_btn.show()
	game_canvas.hide()
	game_over_canvas.hide()
	
func _get_card(num, col, icon):
	var new_card = card_prefab.instantiate()
	var path: String
	path = "res://Image/" + str(num) + ".png" 
	
	
	if icon == 1:
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/heart.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/heart.png")
	elif icon == 2:
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/clover.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/clover.png")
	elif icon == 3:
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/dia.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/dia.png")
	elif icon == 4:
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/spade.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/spade.png")
	
	if num < 11:
		new_card.get_node("Card Sprite/num/Num Icon").texture = load(path)
	elif num == 11:
		new_card.get_node("Card Sprite/num/Num Icon").texture = preload("res://Image/j.png")
	elif num == 12:
		new_card.get_node("Card Sprite/num/Num Icon").texture = preload("res://Image/q.png")
	elif num == 13:
		new_card.get_node("Card Sprite/num/Num Icon").texture = preload("res://Image/k.png")

			
	if col == 0: 
		new_card.get_node("Card Sprite/main/Main Icon").modulate = Color.RED
		new_card.get_node("Card Sprite/small/Small Icon").modulate = Color.RED
		new_card.get_node("Card Sprite/num/Num Icon").modulate = Color.RED
	elif col == 1: 
		new_card.get_node("Card Sprite/main/Main Icon").modulate = Color.BLACK
		new_card.get_node("Card Sprite/small/Small Icon").modulate = Color.BLACK
		new_card.get_node("Card Sprite/num/Num Icon").modulate = Color.BLACK
		
	card_pos.add_child(new_card)	
		
	
func _get_random_card():
	card_sound.play()
	var new_card = card_prefab.instantiate()
		
	var random = randi() % 7
	GameManager.card_icon = random
	if random == 0: 
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/heart.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/heart.png")
	elif random == 1: 
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/clover.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/clover.png")
	elif random == 2: 
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/dia.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/dia.png")
	elif random == 3: 
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/spade.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/spade.png")
	elif random == 4: 
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/king.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/king.png")
	elif random == 5: 
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/queen.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/queen.png")
	elif random == 6: 
		new_card.get_node("Card Sprite/main/Main Icon").texture = preload("res://Image/sword.png")
		new_card.get_node("Card Sprite/small/Small Icon").texture = preload("res://Image/sword.png")
			
	var color_ran = randi() % 2
		
	if color_ran == 0: 
		new_card.get_node("Card Sprite/main/Main Icon").modulate = Color.RED
		new_card.get_node("Card Sprite/small/Small Icon").modulate = Color.RED
		new_card.get_node("Card Sprite/num/Num Icon").modulate = Color.RED
	elif color_ran == 1: 
		new_card.get_node("Card Sprite/main/Main Icon").modulate = Color.BLACK
		new_card.get_node("Card Sprite/small/Small Icon").modulate = Color.BLACK
		new_card.get_node("Card Sprite/num/Num Icon").modulate = Color.BLACK
			
	if random < 4:		
		var ran_num = randi() % 10
		var path: String
		new_card_num = ran_num + 1
		path = "res://Image/" + str(new_card_num) + ".png" 
		#print(path)
		new_card.get_node("Card Sprite/num/Num Icon").texture = load(path)
	else:
		if random == 4:
			new_card_num = 13
			new_card.get_node("Card Sprite/num/Num Icon").texture = preload("res://Image/k.png")
		if random == 5:
			new_card_num = 12
			new_card.get_node("Card Sprite/num/Num Icon").texture = preload("res://Image/q.png")
		if random == 6:
			new_card_num = 11
			new_card.get_node("Card Sprite/num/Num Icon").texture = preload("res://Image/j.png")
		
	if previous_card_num != new_card_num || previous_card_num == -1:
		card_pos.add_child(new_card)
	else: 
		if previous_card_num == new_card_num: _get_random_card()

	GameManager.current_card = new_card_num
	GameManager.card_color = color_ran
	#print(new_card_num)

func _remove_previous_card():
	if card_pos.get_child_count() != 0:
		var card = card_pos.get_child(card_pos.get_child_count() - 1)
		card_pos.remove_child(card)

func _on_start_game_btn_pressed():
	GameManager.current_score = 0
	GameManager.card_started = true
	click_sound.play()
	game_started = true
	start_btn.hide()
	game_canvas.show()


func _on_down_btn_pressed():
	click_sound.play()
	_remove_previous_card()
	previous_card_num = new_card_num
	GameManager.previous_card = previous_card_num
	_remove_previous_card()
	_get_random_card()
	
	if previous_card_num > new_card_num:
		print("pre: ", previous_card_num, "  /  ", "new: ", new_card_num)
		game_success_sound.play()
		score += 10
		GameManager.current_score = score
		GameManager.card_failed = false
		#_remove_previous_card()
		#_get_card()
	else:
		print("pre: ", previous_card_num, "  /  ", "new: ", new_card_num)
		game_fail_sound.play()
		game_over_canvas.show()
		GameManager.card_failed = true
	

func _on_up_btn_pressed():
	click_sound.play()
	_remove_previous_card()
	previous_card_num = new_card_num
	_remove_previous_card()
	_get_random_card()
	
	if previous_card_num < new_card_num:
		print("pre: ", previous_card_num, "  /  ", "new: ", new_card_num)
		game_success_sound.play()
		score += 10
		GameManager.current_score = score
		
		GameManager.card_failed = false
		#_remove_previous_card()
		#_get_card()
	else:
		print("pre: ", previous_card_num, "  /  ", "new: ", new_card_num)
		game_fail_sound.play()
		game_over_canvas.show()
		GameManager.card_failed = true


func _on_game_over_btn_pressed():
	click_sound.play()
	_reset_game()
