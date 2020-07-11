extends Node

onready var grid = get_node("../grid")

# Will be used for cell highlighting
func _process(delta):
	var mousePos = grid.get_global_mouse_position()
	if grid.isWithinGrid(grid.world_to_map(mousePos)):
		var CellHover = get_node("../grid/CellHover")
		CellHover.position = grid.map_to_world(grid.world_to_map(mousePos))
		if grid.collectedPotion == 0:
			CellHover.modulate = Color(1,1,1)
		elif grid.collectedPotion == 1:
			CellHover.modulate = Color(1,0,0)
		elif grid.collectedPotion == 2:
			CellHover.modulate = Color(0,1,0)
		elif grid.collectedPotion == 3:
			CellHover.modulate = Color(0.2,0.2,0.2)
		checkPosValid(CellHover)


func _input(event):
	# Checks if event is mouse click
	if event is InputEventMouseButton:
		pass

func checkPosValid(cellHover):
	var cellPos = grid.world_to_map(cellHover.position)
	if !(grid.get_node("wallTiles").get_cellv(cellPos) == -1 && grid.grid[cellPos.x][cellPos.y] == null):
		cellHover.visible = false
	else:
		cellHover.visible = true
