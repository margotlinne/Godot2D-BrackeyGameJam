extends Node2D


@onready var computer_btn = $"../MonitorScreen/ComputerSceneBtn"
@onready var monitor_sprite = $"../MonitorScreen/Monitor"


func _process(delta):
	pass


func _on_computer_scene_btn_pressed():
	GameManager.load_scene("res://Scene/Computer.tscn")


func _on_paper_work_scene_btn_pressed():
	GameManager.load_scene("res://Scene/PaperWork.tscn")

# 모니터 버튼 위 호버
func _on_computer_scene_btn_mouse_entered():
	var material = monitor_sprite.get_material()
		
	if material is ShaderMaterial:
		var shader_material = material as ShaderMaterial
			
		# 셰이더 파라미터를 설정합니다.
		shader_material.set_shader_parameter("progress", 1.0)  # 아웃라인 두께
	else:
		print("Material은 ShaderMaterial이 아닙니다.")
		
func _on_computer_scene_btn_mouse_exited():
	var material = monitor_sprite.get_material()
		
	if material is ShaderMaterial:
		var shader_material = material as ShaderMaterial
			
		# 셰이더 파라미터를 설정합니다.
		shader_material.set_shader_parameter("progress", 0.0)  # 아웃라인 두께
	else:
		print("Material은 ShaderMaterial이 아닙니다.")
