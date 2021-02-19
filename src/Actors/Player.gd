extends Area2D

# Signal for knowing we were picked up
signal clicked

# Signal that we were dropped and should be flying
signal dropped

# Starting position
export(Vector2) var StartingPosition

# Velocity imparted by launcher
export var Velocity: = Vector2.ZERO 

# Mass to calculate movement
export var Mass: = 500

# Pointer to the catapult
onready var Catapult = $".."

# State of the player sprite
# 0: In place at beginning
# 1: Held by the player
# 2: Released and flying
enum State {WAIT, HELD, FLYING}
var state 

func _ready():
	position = StartingPosition
	state = State.WAIT
	
func pickup():
	if state == State.WAIT:
		print("Player picked up")
		state = State.HELD
	
# Drop the object, possibly with some force from the mouse movement
func drop(impulse=Vector2.ZERO):
	if state == State.HELD:
		print("Player dropped with %s impulse", impulse)
		state = State.FLYING
		Velocity = impulse

func _physics_process(delta):
	if state == State.FLYING:
		position += Velocity * delta
	elif state == State.HELD:
		var current_pos = get_global_mouse_position()
		
		# Keep it within the boundaries
		var distance = current_pos - Catapult.global_position
		if distance.length() > Catapult.Maximum_Stretch:
			current_pos = (distance.normalized() * Catapult.Maximum_Stretch) + Catapult.global_position
		set_global_position(current_pos)
		Catapult.set_line_point(current_pos)

# Translate a click into a click event
func _input_event(viewport, event, shape_idx):
	# Are we waiting to be picked up?
	if state == State.WAIT:
		# If so, check for the click
		if event is InputEventMouseButton and event.is_pressed():
			emit_signal("clicked")
			
	# Are we currently being held?
	if state == State.HELD:
		# If so, check if the mouse button was released
		if event is InputEventMouseButton and !event.is_pressed():
			emit_signal("dropped")

	# We ignore input events if we're flying
