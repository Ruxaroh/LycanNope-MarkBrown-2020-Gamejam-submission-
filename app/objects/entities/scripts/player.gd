extends KinematicBody2D

signal playerTurnFinished

var heroTurn := true
var moveDir = Vector2()
var grid
var foundTarget
var type = 1

var extraTurn = false
var form = "hero"
var animStart := false
var animDone := false


func _ready():
	grid = get_parent().get_parent()
	set_physics_process(false)
	var turnController = get_parent().get_parent().get_node("turnController")
	connect("playerTurnFinished", turnController, "turnControl")

func playerTurn():
	set_physics_process(true)

func _physics_process(delta):


	if form == "hero":
		foundTarget = grid.findNpcInRange(self)
	if extraTurn:
		foundTarget = null

	if foundTarget == null:
		moveDir = $heroMovement.getMoveDir()
		if moveDir != Vector2.ZERO:
			if grid.isCellVacent(position, moveDir, "player"):
				$Tween.interpolate_property(self, "position",position,grid.updateChildPos(self),0.2,$Tween.TRANS_LINEAR)
				$Tween.start()
				$footstepSFX1.play()
				
				set_physics_process(false)
				if extraTurn:
					extraTurn = false
				emit_signal("playerTurnFinished")
	else:
		if !animDone && !animStart:
			transform()
			animStart = true
		elif !animDone:
			pass
		elif form == "villain":
			if grid.isCellVacent(position, foundTarget, "player"):
				moveDir = foundTarget
				$Tween.interpolate_property(self, "position",position,grid.updateChildPos(self),0.2,$Tween.TRANS_LINEAR)
				$Tween.start()
				#set_physics_process(false)

func transform():
	if form == "hero":
		form = "villain"
	else:
		form = "hero"
	$transformSFX.play()
	$transformParticle.emitting = true
	$transformDelay.start()
	
	get_tree().get_root().get_node("levelHandeler/MainCamera").transform()


func _on_transformDelay_timeout():
	if $playerSprite.animation == "hero" && !animDone:
		$playerSprite.play("villain")
		$transformDelay2.start()
	elif $playerSprite.animation == "villain" && animDone:
		$playerSprite.play("hero")
		$transformDelay2.start()

func _on_transformDelay2_timeout():
	if !animDone:
		animDone = true
	else:
		animStart = false
		animDone = false
		extraTurn = true
		playerTurn()
