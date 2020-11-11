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

func _process(delta):
	if state == State.FLY:
		position += Velocity * delta

# Translate a click into a click event
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

