extends Node

var playerTurn := true
signal playerTurn
signal gameTurn

func _ready():	
	var player = get_node("../grid/player")
	connect("playerTurn", player, "playerTurn")
	
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		connect("gameTurn", npc, "move")
	turnControl()

func turnControl():
	if playerTurn:
		print("Player Turn")
		emit_signal("playerTurn")
		playerTurn = false
	else:
		print("Game Turn")
		$GameTimer.start()

func _on_GameTimer_timeout():
	emit_signal("gameTurn")
	playerTurn = true
	turnControl()
