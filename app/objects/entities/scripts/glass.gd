extends KinematicBody2D


var type = 6
var player = get_parent().get_node("player")
#connect("glassSmashed", turnController, "turnControl")

# Called when the node enters the scene tree for the first time.
func
