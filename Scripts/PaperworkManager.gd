extends Control

@onready var paper_prefab = preload("res://Scene/paper.tscn")
@onready var paper_container = $ColorRect/PaperContainer
@onready var stamp_point = $ColorRect/StampPoint
@onready var right_hand = $ColorRect/StampPoint/RightHand
@onready var stamp_prefab = preload("res://Scene/stamp_prefab.tscn")

var speed = 500
var slow_speed = 300
var left_clicked = false
var stop = false
var success_count = 0
var total_count = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)  
	total_count = randi_range(10, 35)
	for i in range(total_count):
		var new_paper = paper_prefab.instantiate()
		paper_container.add_child(new_paper)    
		if GameManager.current_paper_work == "Henry Adams":
			new_paper.modulate = Color.ORANGE        
		elif GameManager.current_paper_work == "Chloe King":
			new_paper.modulate = Color.SLATE_GRAY        
		elif GameManager.current_paper_work == "Harper Allen":
			new_paper.modulate = Color.PALE_GREEN 
		elif GameManager.current_paper_work == "William Scott":
			new_paper.modulate = Color.SADDLE_BROWN
		elif GameManager.current_paper_work == "Louis Black":
			new_paper.modulate = Color.PINK

func _process(delta):
	# 마우스 중앙에 고정 
	Input.warp_mouse(stamp_point.position)
	
	if Input.is_action_pressed("ui_cancel") && stop: 
		GameManager.load_scene("res://Scene/DeskView.tscn")
		
	# 스페이스바 눌러서 느리게 움직이게 하기 
	if Input.is_action_pressed("ui_accept"):
		#print("spacebar")
		speed = slow_speed
	else:
		speed = 500  # 기본 속도로 돌아가기
	
	# 오른쪽으로 움직이기
	if !stop:
		paper_container.position.x += speed * delta
	
	# 도장 찍기
	if left_clicked:
		right_hand.get_node("AnimationPlayer").play("stamp_motion")
		left_clicked = false
		for i in paper_container.get_children():
			var parent = i.get_node("Control/Node2D")
			#print(i.name, " ", i.is_hover)
			if i.is_hover:
				await get_tree().create_timer(0.2).timeout
				var new_stamp = stamp_prefab.instantiate()
				new_stamp.position = parent.to_local(stamp_point.position)
				parent.add_child(new_stamp)
				success_count += 1
				
	
	var parent = paper_container.get_child(0).get_node("Control/Node2D")
	if parent.global_position.x > 1160:
		stop = true
	
	if stop:
		var item = GameManager.get_item("paper", GameManager.current_paper_work)
		print("total success: ", success_count, "/ total_counts", total_count)
		if success_count == total_count:
			item.isFailed = false
			item.isDone = true
		else:
			item.isFailed = true
			item.isDone = true

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			left_clicked = true
