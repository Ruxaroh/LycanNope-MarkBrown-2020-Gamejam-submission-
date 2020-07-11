extends KinematicBody2D

# Base Info
var grid
var type
var moveDir = Vector2(0, 0)
export var enemy : bool = false

func _ready():
	type = 4 # type 4 = npc
	grid = get_parent()
	# set_physics_process(true)
	setShirtColour()

# Move in current direction, if blocked, change direction
func move():
	if moveDir != Vector2.ZERO:
		if grid.isCellVacent(position, moveDir):
			position = grid.updateChildPos(self)
		else:
			# npc turns to try and go the other way
			moveDir = -moveDir
			if grid.isCellVacent(position, moveDir):
				position = grid.updateChildPos(self)
			else:
				# If here npc is blocked both sides
				pass

# Will be used to assign npc sprite
func setShirtColour():
	pass


func die():
	if enemy:
		# Open exit? Give character key?
		pass
	else:
		pass
		# Game Over
