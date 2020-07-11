extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	var charPos = get_parent().get_node("actors").get_node("player").position
	position = Vector2(charPos.x + 32, charPos.y + 32)

	var collectedPotion = get_parent().collectedPotion
	if collectedPotion == 1:
		pass
