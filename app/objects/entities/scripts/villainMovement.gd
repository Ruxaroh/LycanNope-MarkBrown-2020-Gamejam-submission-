extends Node

var rng = RandomNumberGenerator.new()
var allowTurn = false

func getMoveDir():
	
	var moveDir = Vector2(0,0)
	
	# Set movment checks to variables (True = 1)
	
	# Sets movedirection, if both pressed = 0
	if allowTurn:
		while (moveDir.x != 0 && moveDir.y != 0) || (moveDir.x == 0 && moveDir.y == 0):
			moveDir.x = rng.randi_range(-1,1)
			moveDir.y = rng.randi_range(-1,1)
		allowTurn = false
		
	return(moveDir)


func _on_turnDelay_timeout():
	allowTurn = true
