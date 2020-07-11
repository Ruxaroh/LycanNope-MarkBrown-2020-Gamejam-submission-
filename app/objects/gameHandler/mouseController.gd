extends Node

onready var grid = get_node("../grid")

# Will be used for cell highlighting
func _process(delta):
	var mousePos = grid.get_global_mouse_position()
	if grid.isWithinGrid(grid.world_to_map(mousePos)):
		var CellHover = get_node("../grid/CellHover")
		CellHover.position = grid.map_to_world(grid.world_to_map(mousePos))
		print("Mouse Motion at: ", mousePos)


func _input(event):
	# Checks if event is mouse click
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		print(grid.isCellVacent(event.position, Vector2(0,0), "mouse"))
