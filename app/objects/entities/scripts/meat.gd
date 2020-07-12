extends KinematicBody2D

signal meatSmashed
var type = 7


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_parent().get_node("player")
	connect("meatSmashed", player, "transform")

func smash():
	emit_signal("meatSmashed")
	get_parent().remove_child(self)
	queue_free()
