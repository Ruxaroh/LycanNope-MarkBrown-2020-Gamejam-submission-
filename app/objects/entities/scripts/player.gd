extends KinematicBody2D

var heroTurn := true
var moveDir = Vector2()
var grid
var type = 1

func _ready():
	grid = get_parent()
	grid.updateChildPos(self)
	set_physics_process(true)

func _physics_process(delta):
	if heroTurn:
		moveDir = $heroMovement.getMoveDir()
	else:
		moveDir = $villainMovement.getMoveDir()
	
	if moveDir != Vector2.ZERO:		
		if grid.isCellVacent(position, moveDir):
			position = grid.updateChildPos(self)
