extends Node2D

# How far can we stretch the player
export var Maximum_Stretch := 100

# References to the lines
onready var LeftBand = $"LeftAnchor/LeftBand"
onready var RightBand = $"RightAnchor/RightBand"

# References to the anchors
onready var LeftPoint = $"LeftAnchor".global_position
onready var RightPoint = $"RightAnchor".global_position

# Reference to the center 
onready var Center = global_position

# Get a reference to the player
onready var Player = $Player

# React to the player being picked up
func _on_Player_clicked():
	Player.pickup()

# Impart the right impulse when the player is dropped
func _on_Player_dropped():
	var impulse = global_position - Player.global_position
	Player.drop(impulse)

# Set the line end points
func set_line_point(pos:Vector2):
	var left_endpoint = pos - LeftPoint
	var right_endpoint = pos - RightPoint
	LeftBand.set_point_position(1, left_endpoint)
	RightBand.set_point_position(1, right_endpoint)
	
