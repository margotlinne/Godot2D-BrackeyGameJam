extends VBoxContainer

@onready var papers_prefab = preload("res://Scene/papers_prefab.tscn")
@onready var done_papers_prefab = preload("res://Scene/done_paper_prefab.tscn")
@onready var finished_papers = $"../FinishedPapers"

var displayed_papers_sender = []
var finished_papers_sender = []

func _ready():
	_set_papers()
		
func _process(delta):
	_set_papers()

func _get_papers(sender):
	for i in self.get_children():
		#print("finding...", i.sender)
		if i.sender == sender:
			return i
			
		


func _set_papers():
	for i in GameManager.email_ins.email_paper:
		if i.isPaperWork:
			if i.isActive:
				var new_papers = null
				
				# 이미 활성화시켰던 페이퍼가 있는 경우 
				if i.from not in displayed_papers_sender:
					new_papers = papers_prefab.instantiate()
					self.add_child(new_papers)
					displayed_papers_sender.append(i.from)
				
					if i.from == "Henry Adams":
						new_papers.get_node("ColorImage").modulate = Color.ORANGE        
					elif i.from == "Chloe King":
						new_papers.get_node("ColorImage").modulate = Color.SLATE_GRAY        
					elif i.from == "Harper Allen":
						new_papers.get_node("ColorImage").modulate = Color.PALE_GREEN 
					elif i.from == "William Scott":
						new_papers.get_node("ColorImage").modulate = Color.SADDLE_BROWN
					elif i.from == "Louis Black":
						new_papers.get_node("ColorImage").modulate = Color.PINK
					new_papers.sender = i.from
					new_papers.set = true
					#print("displayed: ", displayed_papers_sender)
					
			#완료된 경우 왼쪽에서 제거 후 오른쪽에 추가
			if i.isDone:
				var done_papers = null
				
				if i.from not in finished_papers_sender:
					done_papers = done_papers_prefab.instantiate()
					finished_papers.add_child(done_papers)
					finished_papers_sender.append(i.from)
				
					if i.from == "Henry Adams":
						done_papers.get_node("Image").modulate = Color.ORANGE        
					elif i.from == "Chloe King":
						done_papers.get_node("Image").modulate = Color.SLATE_GRAY        
					elif i.from == "Harper Allen":
						done_papers.get_node("Image").modulate = Color.PALE_GREEN 
					elif i.from == "William Scott":
						done_papers.get_node("Image").modulate = Color.SADDLE_BROWN
					elif i.from == "Louis Black":
						done_papers.get_node("Image").modulate = Color.PINK
					
					done_papers.sender = i.from
					#displayed_papers_sender.remove_at(_get_papers(i.from).sender)
					self.remove_child(_get_papers(i.from))
					#print(i.from, " ", _get_papers(i.from))
					
			if i.isSent:
				for j in finished_papers.get_children():
					if j.sender == i.from:
						finished_papers.remove_child(j)
				for j in self.get_children():
					if j.sender == i.from:
						self.remove_child(j)
#	if self.get_child_count() > 0:		
#		#현재 자식 노드를 가져옵니다.
#		var children = []
#		for i in range(self.get_child_count()):
#			children.append(self.get_child(i))
#			self.remove_child(self.get_child(i))
#		# 자식 노드를 역순으로 정렬합니다.
#		children.reverse()
#		# 역순으로 재배치합니다.
#		for child in children:
#			self.add_child(child)		
#
#	if finished_papers.get_child_count() > 0:		
#		#현재 자식 노드를 가져옵니다.
#		var children = []
#		for i in range(finished_papers.get_child_count()):
#			children.append(finished_papers.get_child(i))
#			finished_papers.remove_child(finished_papers.get_child(i))
#		# 자식 노드를 역순으로 정렬합니다.
#		children.reverse()
#		# 역순으로 재배치합니다.
#		for child in children:
#			finished_papers.add_child(child)		
			
					
	var index = self.get_child_count() - 1
	for i in self.get_children():
		i.z_index = index
		index -= 1
		
	var index2 = finished_papers.get_child_count() - 1
	for i in finished_papers.get_children():
		i.z_index = index2
		index2 -= 1
