extends Area2D

export var speed: int = 400 # pixels/second
var screen_size: Vector2 = Globe.scrnDim
var previousKeyPress: Dictionary = { KEY_Z: false, KEY_X: false}

onready var animateNode = $Animation

func _init():
	connect("area_entered", self, "area_collision")
	connect("area_exited", self, "area_uncollision")
func _ready():
	if (screen_size != get_viewport_rect().size):
		print ("*** Doh *** ", screen_size, " ", get_viewport_rect())
	
	return
	
func _physics_process(delta):
	var velocity: Vector2 = Vector2()
	
	if (Input.is_action_pressed("ui_right")):
		velocity.x += 1
	if (Input.is_action_pressed("ui_left")):
		velocity.x -= 1
	if (Input.is_action_pressed("ui_up")):
		velocity.y -= 1
	if (Input.is_action_pressed("ui_down")):
		velocity.y += 1
	if (Input.is_key_pressed(KEY_Z)):
		if (!previousKeyPress[KEY_Z]):
			animateNode.rotation_degrees += 90
		previousKeyPress[KEY_Z] = true
	else:
		previousKeyPress[KEY_Z] = false
	
	if (velocity.length_squared() > 0):
		velocity = velocity.normalized() * speed
		animateNode.set_rotation( velocity.angle() + PI / 2 )
		animateNode.play()
	else:
		animateNode.stop()
		animateNode.frame = 0
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
func rename_to_activate_inputhandler(event): # _unhandled_key_input(event):
	if (event.scancode == KEY_Z):
		if (event.echo || !event.pressed):
			return
		animateNode.rotation_degrees += 90
		get_tree().set_input_as_handled()
	else: # Input not handled
		return
		
	
	
func area_collision(collider):
	if (collider is Globe.enemyClass):
		animateNode.modulate = Color(1, 1, 1, 0.5)
	else:
		animateNode.modulate = Color(0, 1, 0, 1)
	
func area_uncollision(collider):
	var overlaps: Array = get_overlapping_areas()
	var count: int = overlaps.size()
	var threshold: int = 0

	if (overlaps.find(collider) > -1): # collider not yet removed from overlaps array
		threshold += 1

	if (count > threshold): # check for overlap other than the area being exited
		return
		
	animateNode.modulate = Color(1, 1, 1, 1)
