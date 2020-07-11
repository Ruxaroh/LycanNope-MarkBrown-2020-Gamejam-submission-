extends Node

# Will be used for cell highlighting
func _process(delta):
	return
	var mousePos = get_node("../").get_global_mouse_position()
	print("Mouse Motion at: ", mousePos)


func _input(event):
	# Checks if event is mouse click
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		print(get_node("../grid").isCellVacent(event.position, Vector2(0,0), "mouse"))
