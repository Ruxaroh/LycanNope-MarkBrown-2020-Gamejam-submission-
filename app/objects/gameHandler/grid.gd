extends TileMap

# PLAYER = 1 View Block = 2 COLLECTABLE = 3 NPC = 4


var grid = []
var gridSize = Vector2(20, 11)
var collectedPotion


onready var playerScene = load("res://app/objects/entities/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(gridSize.x):
		grid.append([])
		for y in range(gridSize.y):
			grid[x].append(null)
	for child in $actors.get_children():
		var childPos = world_to_map(child.position)
		grid[childPos.x][childPos.y] = child.type
	
func isCellVacent(pos, direction):
	var gridPos = world_to_map(pos) + direction
	if gridPos.x < gridSize.x && gridPos.x >= 0:
		if gridPos.y < gridSize.y && gridPos.y >= 0:
			print(get_parent().get_node("turnController").playerTurn)
			if grid[gridPos.x][gridPos.y] == 3 && get_parent().get_node("turnController").playerTurn:
				print("hi")
				for child in $actors.get_children():
					if world_to_map(child.position) == gridPos:
						collectedPotion = child.effect
						grid[gridPos.x][gridPos.y] = null
						child.queue_free()
						break
			if $wallTiles.get_cellv(gridPos) == -1 && grid[gridPos.x][gridPos.y] == null:
				return true
	return false

func updateChildPos(child):
	var gridPos = world_to_map(child.position)
	grid[gridPos.x][gridPos.y] = null
	
	var newGridPos = gridPos + child.moveDir
	grid[newGridPos.x][newGridPos.y] = child.type
	
	var targetPos = map_to_world(newGridPos)
	return targetPos
	


func findNpcInRange(child):
	var childPos = world_to_map(child.position)
	
	for x in range(childPos.x, gridSize.x):
		if $wallTiles.get_cellv(Vector2(x, childPos.y)) > -1:
			break
		if grid[x][childPos.y] == 4:
			return(Vector2(1, 0))
	
	for x in range(childPos.x, 0, -1):
		if $wallTiles.get_cellv(Vector2(x, childPos.y)) > -1:
			break
		elif grid[x][childPos.y] == 4:
			return(Vector2(-1, 0))	
	
	for y in range(childPos.y, gridSize.y):
		if $wallTiles.get_cellv(Vector2(childPos.x, y)) > -1:
			break
		if grid[childPos.x][y] == 4:
			return(Vector2(0, 1))	
	
	for y in range(childPos.y, 0, -1):
		if $wallTiles.get_cellv(Vector2(childPos.x, y)) > -1:
			break
		if grid[childPos.x][y] == 4:
			return(Vector2(0, -1))

	return(null)
