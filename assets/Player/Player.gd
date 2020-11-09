extends RigidBody2D
# extends CollisionShape2D

# Have we clicked on the planet?
signal clicked

# Is it currently held by the player?
var held = false

# Process user input
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

# Move the body if we're being held
func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

# Pickup the object, but make it static so we don't process physics yet
func pickup():
	if not held:
		mode = RigidBody2D.MODE_STATIC
		held = true

# Drop the object, possibly with some force from the mouse movement
func drop(impulse=Vector2.ZERO):
	if held:
		mode = RigidBody2D.MODE_RIGID
		apply_central_impulse(impulse)
		held = false
