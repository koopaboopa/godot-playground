extends Node # Autoload scripts must extend Node

const ASDF = [27, 33.75]
var scrnDim = Vector2(800, 600)
const enemyClass = preload("res://dodge/Enemy0.gd")
const playerClass = preload("res://dodge/Player.gd")

func _ready():
	# Default Background Color # _enter_tree() and _init() work too
	VisualServer.set_default_clear_color( Color.whitesmoke )

#func _process(delta):
#	pass
