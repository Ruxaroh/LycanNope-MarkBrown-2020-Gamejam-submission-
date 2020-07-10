extends Node


func getMoveDir():
	
	var moveDir = Vector2()
	
	# Set movment checks to variables (True = 1)
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	# Sets movedirection, if both pressed = 0
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	
	# Check to see if two directions are pressed, prevents diagonals
	if (moveDir.x != 0 && moveDir.y != 0):
		moveDir = Vector2.ZERO

	return(moveDir)

func _process(delta):
	pass
