extends KinematicBody2D

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
