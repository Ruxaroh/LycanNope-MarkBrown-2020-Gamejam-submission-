extends Node

var rng = RandomNumberGenerator.new()

func getMoveDir():
	
	var moveDir = Vector2()
	
	# Set movment checks to variables (True = 1)
	
	# Sets movedirection, if both pressed = 0
	moveDir.x = rng.randi_range(-1,1)
	moveDir.y = rng.randi_range(-1,1)
	
	# Check to see if two directions are pressed, prevents diagonals
	if (moveDir.x != 0 && moveDir.y != 0):
		moveDir = Vector2.ZERO

	return(moveDir)
