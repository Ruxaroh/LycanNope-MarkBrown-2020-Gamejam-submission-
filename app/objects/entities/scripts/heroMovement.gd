extends Node

# MOVMENT CONSTS
const TOP = Vector2(0, -1)
const RIGHT = Vector2(1, 0)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)

var moveDir = Vector2()

func getMoveDir():
	if Input.is_action_just_pressed("ui_up"):
		moveDir = TOP
	elif Input.is_action_just_pressed("ui_right"):
		moveDir = RIGHT
	elif Input.is_action_just_pressed("ui_down"):
		moveDir = DOWN
	elif Input.is_action_just_pressed("ui_left"):
		moveDir = LEFT
	else:
		moveDir = Vector2.ZERO
		
	return(moveDir)

func _process(delta):
	pass
