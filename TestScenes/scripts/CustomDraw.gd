extends Node2D
export var speed: int = 400 # pixels/second
export var keyboardMovement: bool = true
export var drawVector: Vector2 = Vector2(0, 0)
var screenSize: Vector2 = Globe.scrnDim
var justPressed: Dictionary = { ENLARGE_ACTION: false, RESET_ACTION: false }

var startAngle: float = -90
var angleSize: float = 60
var angleDelta: float = 100 # degrees per second

enum {
	ENLARGE_ACTION
	RESET_ACTION
}

func _draw():
	draw_circle( drawVector, 200, Color.lightblue )
	draw_arc( drawVector, 200, startAngle, angleSize, Color.lightcoral )

# Function arguments are in degrees for angles
func draw_arc(center: Vector2, radius: float, angle_from: float, angle_size: float, color: Color):
	var segments: int = 32
	var points_arc: PoolVector2Array # points to draw the polygon with
	var points_colors: PoolColorArray
	
	var arcStart: float
	var arcLength: float
	var arcSeparation: float # angle in radians between the polygon points
	
	
	arcStart = deg2rad(angle_from)
	arcLength = deg2rad(angle_size)
	arcSeparation = arcLength / segments
	points_arc = PoolVector2Array()
	points_colors = PoolColorArray([color])
	
	points_arc.append(center)
	for i in range(segments + 1):
		var polyPoint: Vector2
		polyPoint = center + radius * Vector2(cos(arcStart + arcSeparation * i), sin(arcStart + arcSeparation * i))
		points_arc.append(polyPoint)
		
	
	draw_polygon( points_arc, points_colors ) 
	
	return
	
func _unhandled_input(event):
	if (event.is_action_pressed("ui_select")):
		justPressed[ENLARGE_ACTION] = true
	elif (event.is_action_pressed("ui_accept")):
		justPressed[RESET_ACTION] = true
		pass


func _physics_process(delta):
	var velocity: Vector2 = Vector2(0, 0)
	if (keyboardMovement):
		if (Input.is_action_pressed("ui_right")):
			velocity.x += 1
		if (Input.is_action_pressed("ui_left")):
			velocity.x -= 1
		if (Input.is_action_pressed("ui_up")):
			velocity.y -= 1
		if (Input.is_action_pressed("ui_down")):
			velocity.y += 1
			
		velocity = velocity.normalized() * speed
		position += velocity * delta
		
		position.x = clamp(position.x, 0, screenSize.x)
		position.y = clamp(position.y, 0, screenSize.y)
	
	if (justPressed[RESET_ACTION]):
		angleSize = 0
		justPressed[RESET_ACTION] = false	
	if (justPressed[ENLARGE_ACTION]):
		angleSize += 10
		if (angleSize > 360):
			angleSize = 360
		justPressed[ENLARGE_ACTION] = false
	
	startAngle += angleDelta * delta
	if (startAngle > 360):
		startAngle -= 360
		print("Wraparound Angle: ", startAngle)
	elif(startAngle < 0):
		startAngle += 360
		print("Wraparound Angle: ", startAngle)
	
	update()