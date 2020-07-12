extends Node

var playerTurn := false
signal playerTurn
signal gameTurn

func _ready():	
	var player = get_parent().get_node("actors").get_node("player")
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
		emit_signal("playerTurn")
	else:
		$GameTimer.start()
		emit_signal("gameTurn")

func _on_GameTimer_timeout():
	#emit_signal("gameTurn")
	turnControl()
