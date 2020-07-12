extends KinematicBody2D

signal slimeSmashed
var type = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_parent().get_node("player")
	connect("slimeSmashed", player, "transform")


func smash():
	$AnimatedSprite.visible = false
	emit_signal("slimeSmashed")

func delete():
	get_parent().remove_child(self)
	queue_free()
