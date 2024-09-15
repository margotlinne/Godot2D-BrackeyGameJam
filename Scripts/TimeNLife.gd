extends Control


@onready var start_marker = $TimeBar/Panel/Image/start
@onready var end_marker = $TimeBar/Panel/Image/end
@onready var time_mark = $TimeBar/Panel/Image/TimeMan
@onready var hearts_ui = $Hearts


func _ready():
	hearts_ui.hide()
	time_mark.position = GameManager.time_man_pos
	GameManager.game_timer -= GameManager.current_passed_time 
	
	var tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT) # 애니메이션 완화 (부드러운 시작과 끝)
	# Tween의 애니메이션 설정
	tween.tween_property(
		time_mark,                  # 애니메이션을 적용할 노드
		"position",                 # 애니메이션할 속성
		end_marker.position,       # 끝값
		GameManager.game_timer                # 애니메이션 시간 (초 단위)
	)
	
func _process(delta):
	GameManager.time_man_pos = time_mark.position
	
	if GameManager.assigned:
		hearts_ui.show()
	_set_hearts()

func _set_hearts():
	var active_hearts = 0
	var hearts = hearts_ui.get_children()
	
	# 현재 visible한 heart 개수 세기
	for i in hearts:
		if i.visible:
			active_hearts += 1

	# active_hearts를 GameManager.hearts에 맞추기
	while active_hearts != GameManager.hearts:
		if active_hearts < GameManager.hearts:
			# active_hearts가 더 적으면 visible하지 않은 heart를 활성화
			for i in hearts:
				if not i.visible:
					i.visible = true
					active_hearts += 1
					break
		elif active_hearts > GameManager.hearts:
			# active_hearts가 더 많으면 visible한 heart를 비활성화
			for i in hearts:
				if i.visible:
					i.visible = false
					active_hearts -= 1
					break
	
	
