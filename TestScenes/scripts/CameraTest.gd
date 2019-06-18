extends "res://TestScenes/scripts/InheritedBase.gd" # This works for some apparent reason?

onready var yellowAreaNode = $YellowArea

func _ready():
	has_method("asdf")
	if (call("has_method", "set_defenestrationCounter")):
		print ("Method \"has\" confirmed...")
	
	print (defenestrationCounter)
	
func _unhandled_key_input(event):
	if event.is_action_pressed("spiral_a"):
		var exists
		
		yellowAreaNode.set("asdf", 16)
		exists = yellowAreaNode.set("monitoring", false)
		print("orz: ", exists)
		
	if Input.is_action_just_pressed("spiral_y"):
		print("oof: ", yellowAreaNode.get("monitoring"), " ", yellowAreaNode.get("asdf"))
		
	if event.is_action_pressed("spiral_x"):
		pass
	return