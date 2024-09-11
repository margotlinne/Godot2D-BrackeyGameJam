extends SubViewport

#const monitor_scene = preload("res://Scene/Computer.tscn")
var sub_viewport : SubViewport
	
	
func _ready():
	# SubViewport 노드를 가져옵니다
	sub_viewport = $"."
	# 씬 B를 인스턴스화하여 SubViewport에 추가
	var scene_instance = GameManager._get_com_scene()
	sub_viewport.add_child(scene_instance)
	
