extends Node

var playerTurn := false
signal playerTurn
signal gameTurn

func _ready():	
	var player = get_node("../grid/actors/player")
	connect("playerTurn", player, "playerTurn")
	
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		connect("gameTurn", npc, "move")
	turnControl()

func turnControl():
	if playerTurn:
		playerTurn = false
	else:
		playerTurn = true
	if playerTurn:
		print("Player Turn")
		emit_signal("playerTurn")
	else:
		print("Game Turn")
		$GameTimer.start()

func _on_GameTimer_timeout():
	emit_signal("gameTurn")
	turnControl()
