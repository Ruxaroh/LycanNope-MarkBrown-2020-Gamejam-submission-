extends Node

onready var grid = get_node("../grid")

var slimeScene = load("res://app/objects/entities/slime.tscn")
var meatScene = load("res://app/objects/entities/meat.tscn")
var smokeScene = load("res://app/objects/entities/smoke.tscn")

# Will be used for cell highlighting
func _process(delta):
	var mousePos = grid.get_global_mouse_position()
	if grid.isWithinGrid(grid.world_to_map(mousePos)):
		var CellHover = get_node("../grid/CellHover")
		CellHover.position = grid.map_to_world(grid.world_to_map(mousePos))
		if grid.collectedPotion == 1:
			CellHover.modulate = Color(1,0,0)
		elif grid.collectedPotion == 2:
			CellHover.modulate = Color(0,1,0)
		elif grid.collectedPotion == 3:
			CellHover.modulate = Color(0.2,0.2,0.2)
		if checkPosValid(CellHover) && grid.collectedPotion in [1,2,3]:
			CellHover.visible = true
		else:
			CellHover.visible = false


func _input(event):
	var newObj
	if event is InputEventMouseButton:
		var mousePos = grid.get_global_mouse_position()
		if grid.isWithinGrid(grid.world_to_map(mousePos)):
			var CellHover = get_node("../grid/CellHover")
			var posStore = CellHover.position
			if checkPosValid(CellHover) && grid.collectedPotion in [1,2,3]:
				var gridPos = grid.world_to_map(CellHover.position)
				if grid.collectedPotion == 1:
					newObj = meatScene.instance()
				elif grid.collectedPotion == 2:
					newObj = slimeScene.instance()
				elif grid.collectedPotion == 3:
					newObj = smokeScene.instance()
				newObj.position = posStore
				grid.grid[gridPos.x][gridPos.y] = newObj.type
				get_parent().get_node("grid").get_node("actors").add_child(newObj)
				grid.collectedPotion = 0
			


func checkPosValid(cellHover):
	var cellPos = grid.world_to_map(cellHover.position)
	if (grid.get_node("wallTiles").get_cellv(cellPos) == -1 && grid.grid[cellPos.x][cellPos.y] == null):
		return(true)
	else:
		return(false)
