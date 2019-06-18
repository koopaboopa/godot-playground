extends Node2D

func _ready():
	test_null_refs()
	
func test_input_handling():
	var e: InputEventKey = InputEventKey.new()
	var arr: Array = InputMap.get_action_list("spiral_a")
	var aButtonEvent = arr[0]
	
	print ("**** Defaults for New Event ****\n", "Scancode: ", e.scancode, "\npressed: ", e.pressed, "\necho: ", e.echo, "\nUnicode: ", e.unicode)
	print ("**** ui_a ****\n", "Scancode: ", aButtonEvent.scancode, "\npressed: ", aButtonEvent.pressed, "\necho: ", aButtonEvent.echo, "\nUnicode: ", aButtonEvent.unicode)
	
func test_null_refs():
	var titaniumNode: = Node2D.new()
	titaniumNode.position = Vector2(0, 3)
	
	var supercell = titaniumNode.get_parent()
	
	print ("Supercell itself: ", supercell)
	print (null == supercell) # ??????
	print ("Supercell Validity: ", is_instance_valid(supercell))
	print ("Titanium Validity: ", is_instance_valid(titaniumNode))

	var hurricane: WeakRef = weakref(supercell) # If we try to initialize a WeakRef to a null object, it will return null
	var adamantium: WeakRef = weakref(titaniumNode)
	
	if (hurricane == null):
		print ("Grrr...")
	print (adamantium.get_ref())
	titaniumNode.free()
	print (adamantium.get_ref()) # After an object is freed, an existing WeakRef to it returns null on get_ref()
	
	print ("Newly-made WeakRef: ", weakref(titaniumNode).get_ref())
	
	
func _unhandled_input(event):
	if (event.is_action("spiral_a")):
		print ("** ui_a detected *** Echo: ", event.is_echo(), ", Pressed:", event.is_pressed())
	
	
	return
