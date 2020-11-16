extends Area2D

# Signal for knowing if we were clicked
signal clicked

# Starting position
export(Vector2) var StartingPosition

# Velocity imparted by launcher
export var Velocity = Vector2.ZERO 

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

func _process(delta):
	if state == State.FLYING:
		position += Velocity * delta
	elif state == State.HELD:
		position = get_global_mouse_position()

# Translate a click into a click event
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

