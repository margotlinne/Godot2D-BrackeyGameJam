extends Control

const card_prefab = preload("res://Scene/card.tscn")

@onready var start_btn = $BG/StartGameBtn
@onready var game_canvas = $BG/GameCanvas
@onready var card_pos = $BG/GameCanvas/CardPos
@onready var game_over_canvas = $BG/GameOverCanvas
@onready var game_window = $"."

@onready var score_text = $BG/GameCanvas/ScoreTxt

var spawn_card
var game_started

var previous_card_num
var new_card_num

var score

func _ready():
	previous_card_num = -1
	new_card_num  = -1
	game_canvas.hide()
	game_over_canvas.hide()
	spawn_card = false
	score = 0
	score_text.text = "Score: " + str(score) 

func _process(delta):
	score_text.text = "Score: " + str(score)
	
	if !game_window.visible:
		_reset_game()
		
	
	if game_started && !spawn_card:
		_get_card()
		spawn_card = true

func _reset_game():
	score = 0
	spawn_card = false
	_remove_previous_card()
	start_btn.show()
	game_canvas.hide()
	game_over_canvas.hide()
	

func _get_card():
	var new_card = card_prefab.instantiate()
		
	var random = randi() % 7
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
			
	var color_ran = randi() % 3
		
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
		print(path)
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
		if previous_card_num == new_card_num: _get_card()

	

func _remove_previous_card():
	if card_pos.get_child_count() != 0:
		var card = card_pos.get_child(card_pos.get_child_count() - 1)
		card_pos.remove_child(card)

func _on_start_game_btn_pressed():
	game_started = true
	start_btn.hide()
	game_canvas.show()


func _on_down_btn_pressed():
	_remove_previous_card()
	previous_card_num = new_card_num
	_get_card()
	
	if previous_card_num > new_card_num:
		score += 10
		_remove_previous_card()
		_get_card()
	else:
		game_over_canvas.show()
	

func _on_up_btn_pressed():
	_remove_previous_card()
	previous_card_num = new_card_num
	_get_card()
	
	if previous_card_num < new_card_num:
		score += 10
		_remove_previous_card()
		_get_card()
	else:
		game_over_canvas.show()


func _on_game_over_btn_pressed():
	_reset_game()
