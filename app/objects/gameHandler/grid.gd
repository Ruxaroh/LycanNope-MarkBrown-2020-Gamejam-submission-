extends TileMap

# PLAYER = 1 OBSTICLE = 2 COLLECTABLE = 3 NPC = 4

var half_cell_size = cell_size / 2
var grid = []
var gridSize = Vector2(16, 16)


onready var playerScene = load("res://app/objects/entities/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(gridSize.x):
		grid.append([])
		for y in range(gridSize.y):
			grid[x].append(null)
	
func isCellVacent(pos, direction):
	var gridPos = world_to_map(pos) + direction
	if gridPos.x < gridSize.x && gridPos.x >= 0:
		if gridPos.y < gridSize.y && gridPos.y >= 0:
			if grid[gridPos.x][gridPos.y] == null:
				return true
	return false

func updateChildPos(child):
	var gridPos = world_to_map(child.position)
	grid[gridPos.x][gridPos.y] = null
	
	var newGridPos = gridPos + child.moveDir
	grid[newGridPos.x][newGridPos.y] = child.type
	
	var targetPos = map_to_world(newGridPos)
	return targetPos
