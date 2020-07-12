extends KinematicBody2D

signal slimeSmashed
var type = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_parent().get_node("player")
	connect("slimeSmashed", player, "transform")


func smash():
	$smashSFX.play()
	$AnimatedSprite.visible = false
	$Particles2D.emitting = true
	emit_signal("slimeSmashed")
	$deleteTimer.start()

func delete():
	get_parent().remove_child(self)
	queue_free()
