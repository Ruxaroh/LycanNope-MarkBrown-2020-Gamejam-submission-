extends KinematicBody2D

# Base Info
var grid
var type
var moveDir = Vector2(0, 0)
export var enemy : bool = false

export var npcType := 0

func _ready():
	type = 4 # type 4 = npc
	grid = get_parent().get_parent()
	# set_physics_process(true)
	setShirtColour()

# Move in current direction, if blocked, change direction
func move():
	if moveDir != Vector2.ZERO:
		if grid.isCellVacent(position, moveDir, "npc"):
			$Tween.interpolate_property(self, "position",position,grid.updateChildPos(self),0.2,$Tween.TRANS_LINEAR)
			$Tween.start()
		else:
			# npc turns to try and go the other way
			moveDir = -moveDir
			if grid.isCellVacent(position, moveDir, "npc"):
				$Tween.interpolate_property(self, "position",position,grid.updateChildPos(self),0.2,$Tween.TRANS_LINEAR)
				$Tween.start()
			else:
				# If here npc is blocked both sides
				pass

# Will be used to assign npc sprite
func setShirtColour():
	match npcType:
		0:
			moveDir = Vector2(0, 0)
			$npcSprite.play("green")
			continue
		1:
			moveDir = Vector2(0, 1)
			$npcSprite.play("red")
			continue
		2:
			moveDir = Vector2(1, 0)
			$npcSprite.play("blue")
			continue


func die():
	if enemy:
		# Open exit? Give character key?
		pass
	else:
		pass
		# Game Over
