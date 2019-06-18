extends Node2D

var dynamicTreeRoot = null # will store the new scene tree we make
var package: PackedScene
var nextPlacementX = 0
var previousKeyState: Dictionary = { KEY_Z: 0, KEY_X: 0 }
onready var initialSpriteNode = $Sprite

func _ready() -> void:
	var tempNode = null
	package = PackedScene.new()
	
	dynamicTreeRoot = Node2D.new()
	dynamicTreeRoot.name = "Hyperion"
	
	### Duplicate node and change it's texture manually ###
	tempNode = initialSpriteNode.duplicate()
	tempNode.texture = load("res://art/enemyFlyingAlt_2.png")
	tempNode.position = Vector2(0, 0)
	tempNode.name = "highlander"
	
	### Add Child to root ###
	dynamicTreeRoot.add_child(tempNode)
	tempNode.owner = dynamicTreeRoot # NOTE: owner must already be a parent/ancestor node in tree
	
	
	remove_child( initialSpriteNode )
	initialSpriteNode.queue_free()
	
	package.pack(dynamicTreeRoot)
	
	# Initial Name for created node tree root
	print ("Initial Node Name: ", dynamicTreeRoot.name)
	dynamicTreeRoot.queue_free()
	
	
#	for x in range(5):
#		tempNode = package.instance()
#		tempNode.position = Vector2(50 + x * 50, 50)
#		print(tempNode.get_class())
#		print(tempNode.get_child_count())
#		add_child(tempNode)
	return

func _physics_process(delta) -> void:
	var tempNode = null
	if (previousKeyState[KEY_X] == 1):
		previousKeyState[KEY_X] = 2
		tempNode = package.instance()
		tempNode.position = Vector2(nextPlacementX, 250)
		add_child(tempNode)
		nextPlacementX += 50
		
		# Display Node Name
		print( "Node Name: ", tempNode.name )

	return
	
func _unhandled_key_input(event):
	if (event.scancode == KEY_X):
		if (event.echo):
			return
		if (!event.pressed):
			previousKeyState[KEY_X] = 0
			return	
		previousKeyState[KEY_X] = 1
	
