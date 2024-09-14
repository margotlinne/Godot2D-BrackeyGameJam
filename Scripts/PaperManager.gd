extends Node2D

@onready var papers_prefab = preload("res://Scene/papers_prefab.tscn")

func _ready():
	for i in GameManager.email_ins.email_paper:
		if i.isActive:
			var new_papers = papers_prefab.instantiate()
			self.add_child(new_papers)


func _process(delta):
	pass
