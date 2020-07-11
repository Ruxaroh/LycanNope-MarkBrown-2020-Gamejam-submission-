extends KinematicBody2D

<<<<<<< HEAD
signal glassSmashed
var type = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_parent().get_node("player")
	connect("glassSmashed", player, "transform")

func smash():
	emit_signal("glassSmashed")
	get_parent().remove_child(self)
	queue_free()
=======

var type = 6
var player = get_parent().get_node("player")
#connect("glassSmashed", turnController, "turnControl")

# Called when the node enters the scene tree for the first time.
func
>>>>>>> 66d4e8b96b9a85a67dda98641b4fb4e1ee63abfb
