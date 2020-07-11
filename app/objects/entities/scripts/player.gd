extends KinematicBody2D

signal playerTurnFinished

var heroTurn := true
var moveDir = Vector2()
var grid
var type = 1

func _ready():
	grid = get_parent()
	set_physics_process(false)
	var turnController = get_tree().get_root().get_node("mainScene/turnController")
	connect("playerTurnFinished", turnController, "turnControl")

func playerTurn():
	set_physics_process(true)

func _physics_process(delta):
	if heroTurn:
		moveDir = $heroMovement.getMoveDir()
	else:
		moveDir = $villainMovement.getMoveDir()
	
	if moveDir != Vector2.ZERO:		
		if grid.isCellVacent(position, moveDir):
			position = grid.updateChildPos(self)
			set_physics_process(false)
			emit_signal("playerTurnFinished")

func transform():
	$transformParticle.emitting = true
	$transformDelay.start()

func _on_transformDelay_timeout():
	$playerSprite.play("villain")
