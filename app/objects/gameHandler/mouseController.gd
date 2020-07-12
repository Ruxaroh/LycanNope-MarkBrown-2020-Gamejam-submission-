extends Node

onready var grid = get_node("../grid")

var slimeScene = load("res://app/objects/entities/slime.tscn")
var meatScene = load("res://app/objects/entities/meat.tscn")
var smokeScene = load("res://app/objects/entities/smoke.tscn")

# Will be used for cell highlighting
func _process(delta):
	var mousePos = grid.get_global_mouse_position()
	# Checks if mouse is within the grid
	if grid.isWithinGrid(grid.world_to_map(mousePos)):
		# Sets Cell Hover position in line with grid
		var CellHover = grid.get_node("CellHover")
		CellHover.position = grid.map_to_world(grid.world_to_map(mousePos))
		
		# Change colour depending on potion collected
		if grid.collectedPotion == 1:
			CellHover.modulate = Color(1,0,0)
		elif grid.collectedPotion == 2:
			CellHover.modulate = Color(0,1,0)
		elif grid.collectedPotion == 3:
			CellHover.modulate = Color(0.2,0.2,0.2)
		
		# Makes CellHover visible if a potion is collected and it can be placed
		if checkPosValid(CellHover) && grid.collectedPotion in [1,2,3]:
			CellHover.visible = true
		else:
			CellHover.visible = false

# Function to enable placing potion effects
func _input(event):
	var potionObj
	if event is InputEventMouseButton:
		# Check if mouse within grid
		var mousePos = grid.get_global_mouse_position()
		if grid.isWithinGrid(grid.world_to_map(mousePos)):
			var CellHover = grid.get_node("CellHover")
			var posStore = CellHover.position
			# Check if posible to place potion
			if checkPosValid(CellHover) && grid.collectedPotion in [1,2,3]:
				# Places potion effect onto grid
				var gridPos = grid.world_to_map(CellHover.position)
				if grid.collectedPotion == 1:
					potionObj = meatScene.instance()
				elif grid.collectedPotion == 2:
					potionObj = slimeScene.instance()
				elif grid.collectedPotion == 3:
					potionObj = smokeScene.instance()
				# Sets position of effect in world
				potionObj.position = posStore
				grid.grid[gridPos.x][gridPos.y] = potionObj.type
				grid.get_node("actors").add_child(potionObj)
				grid.collectedPotion = 0
			


func checkPosValid(cellHover):
	var cellPos = grid.world_to_map(cellHover.position)
	if (grid.get_node("wallTiles").get_cellv(cellPos) == -1 && grid.grid[cellPos.x][cellPos.y] == null):
		return(true)
	else:
		return(false)
