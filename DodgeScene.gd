extends Node2D

onready var backgroundNode = $Background
onready var playerNode = $Player
onready var testNode = $TestArea


func _ready():
	test_func()
	backgroundNode.rect_position = Vector2(0, 0)
	backgroundNode.rect_size = Globe.scrnDim
	
	playerNode.connect("area_exited", self, "player_collision")
	return
	
func test_func():
	return
	
func player_collision( collider ):
	var overlaps = playerNode.get_overlapping_areas()
	print("From GameManager: ", overlaps )
	
	return