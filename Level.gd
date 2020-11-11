extends Node2D

var held_object = null
var held_position

func _ready():
	# Set the player to not moving yet
	#$Player.held = false
	pass

func _on_Player_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()
		held_position = get_global_mouse_position()
		

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			var impulse = held_position - get_global_mouse_position()
			held_object.drop(impulse)
			held_object = null
