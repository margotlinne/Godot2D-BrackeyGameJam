extends Control

var is_hover = false
@onready var image = $Image
var sender = ""
var set = false

func _ready():
	var material = image.get_material()
	if material is ShaderMaterial:
		# ShaderMaterial을 복사하여 독립적으로 설정
		material = material.duplicate(true)
		image.set_material(material)
		
		
func _on_image_mouse_entered():
	is_hover = true


func _on_image_mouse_exited():
	is_hover = false
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and is_hover:
			GameManager.current_paper_work = sender
			print(sender)
			GameManager.load_scene("res://Scene/PaperWork.tscn")
		

func _process(delta):
	var material = image.get_material()
	if material is ShaderMaterial:
		var shader_material = material as ShaderMaterial		
		if is_hover: 
			shader_material.set_shader_parameter("progress", 1.0)  # 아웃라인 두께
		else:
			shader_material.set_shader_parameter("progress", 0.0)  # 아웃라인 두께
	else: print("Material은 ShaderMaterial이 아닙니다.")
