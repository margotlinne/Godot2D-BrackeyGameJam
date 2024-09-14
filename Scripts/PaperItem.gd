extends TextureRect

var is_hover = false

@onready var check_pos = $Control/Node2D
	


#func _on_mouse_entered():
#	is_hover = true
#	print("hovering")
#
#func _on_mouse_exited():
#	is_hover = false


func _on_area_2d_mouse_exited():
	is_hover = false


func _on_area_2d_mouse_entered():
	is_hover = true
	print("hovering")
