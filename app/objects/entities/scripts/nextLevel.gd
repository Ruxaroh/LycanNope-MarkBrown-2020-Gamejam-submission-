extends Node


func nextLevel(nextLevelCode,level):
	get_parent().add_child(load("res://app/levels/" + str(nextLevelCode) + ".tscn").instance())
	get_parent().remove_child(level)
	get_parent().currentLevel = nextLevelCode
	#get_parent().get_node("turnController").turnControl()
