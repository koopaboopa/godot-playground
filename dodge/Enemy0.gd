extends Area2D
class_name MobClass0

onready var sprite = $Sprite

func _ready():
	connect("area_entered", self, "on_area_entered")
	connect("area_exited", self, "on_area_exited")
	
func on_area_entered(collider: Area2D):
	if (collider is Globe.playerClass):
		sprite.modulate = Color(0, 0, 1, 1)

func on_area_exited(collider: Area2D):
	if (collider is Globe.playerClass):
		sprite.modulate = Color(1, 1, 1, 1)