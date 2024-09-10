extends Control


@onready var start_marker = $TimeBar/Panel/Image/start
@onready var end_marker = $TimeBar/Panel/Image/end
@onready var time_mark = $TimeBar/Panel/Image/TimeMan


var DURATION = 600.0  # 10분을 초 단위로 변환 (600초)

func _ready():
	time_mark.position = start_marker.position
	DURATION -= GameManager.current_passed_time 
	
	var tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT) # 애니메이션 완화 (부드러운 시작과 끝)
	# Tween의 애니메이션 설정
	tween.tween_property(
		time_mark,                  # 애니메이션을 적용할 노드
		"position",                 # 애니메이션할 속성
		end_marker.position,       # 끝값
		DURATION                # 애니메이션 시간 (초 단위)
	)
