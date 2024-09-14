extends Control

# 컨테이너 부모
@onready var container_parent = $Window/ScrollContainer/ParentContainer
# 폴더나 아이템 프리팹 
const item_prefab = preload("res://Scene/item.tscn")
@onready var default_item_group = $Window/ScrollContainer/ParentContainer/ItemGroup
var default_grid_container

func _ready():
	default_grid_container = default_item_group.get_node("GridContainer")
	for i in GameManager.files_ins.file:
		var item_ins = item_prefab.instantiate()
		#item_ins.get_script().set_datas(i.name, i.isFolder)
		default_grid_container.add_child(item_ins)
		item_ins.set_datas(i.name, i.isFolder, i.inBin)
		if !i.inBin:
			item_ins.hide()
		else: item_ins.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_visibility():
	for i in default_grid_container.get_children():
		var item = GameManager.get_item("folder", i.its_name)
		i.in_bin = item.inBin
		if i.in_bin: i.show()
		else: i.hide()
