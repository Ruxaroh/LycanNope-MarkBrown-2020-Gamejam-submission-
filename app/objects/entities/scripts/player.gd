extends Sprite

# Base Info
var speed = 256
var tileSize = 32
var playerTurn := true

# Position Tracking
var lastPosition = Vector2()
var targetPosition = Vector2()
var moveDir = Vector2()

func _ready():
	lastPosition = position
	targetPosition = position

func _process(delta):
		# Player Movment
	position += speed * moveDir * delta

	# Correction Snap
	if position.distance_to(lastPosition) >= tileSize:
		position = targetPosition
	
	if position == targetPosition:
		if playerTurn == true:
			moveDir = $heroMovement.getMoveDir()
		else:
			moveDir = $villianMovement.getMoveDir()
		lastPosition = position
		targetPosition += moveDir * tileSize
		if targetPosition != position:
			if !playerTurn:
				playerTurn = true
			else:
				playerTurn = false
