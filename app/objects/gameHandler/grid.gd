extends TileMap

#PLAYER = 1 View Block = 2 COLLECTABLE = 3 NPC = 4 IMPASSABLE = 5 GLASS_&_SLIME = 6 MEAT = 7 SMOKE = 8 STAIRS = 9

var half_cell_size = cell_size / 2
var grid = []
var gridSize = Vector2(20, 11)
var collectedPotion = 0
var steamLocations = []

# Variables for random messages
var rng = RandomNumberGenerator.new()
var noGameOverMessages = 5

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
	

func isCellVacent(pos, direction, asker):
	var gridPos = world_to_map(pos) + direction
	if isWithinGrid(gridPos):
		if grid[gridPos.x][gridPos.y] == 8:
			return(true)
		if asker == "player" && grid[gridPos.x][gridPos.y] == 3:
			collectPotion(gridPos)
		if $actors.get_node("player").animStart == true && grid[gridPos.x][gridPos.y] in [6,7]:
			for child in $actors.get_children():
				if world_to_map(child.position) == gridPos && child.type  in [6,7]:
					child.smash()
					return(true)
		if $actors.get_node("player").animStart == true && grid[gridPos.x][gridPos.y] in [5,9]:
			return(true)
		if $wallTiles.get_cellv(gridPos) == -1 && grid[gridPos.x][gridPos.y] == null:
			return(true)
	if get_node("actors").get_node("player").form == "hero" && asker == "player" && grid[gridPos.x][gridPos.y] == 9:
		get_parent().get_node("nextLevel").nextLevel($actors.get_node("stairs").nextLevelCode, self)
		
	if get_node("actors").get_node("player").form == "villain" && grid[gridPos.x][gridPos.y] == 4 && !$gameOver.visible:
		gameOver()
	
	return(false)

# Game over function
func gameOver():
	if !self.is_queued_for_deletion():
		get_node("/root/levelHandeler/bgMusic").volume_db = -80
	# Chose a random game over message
	var messageScene = load("res://app/gameScenes/gameOverMessage.tscn")
	var message = messageScene.instance()
	
	rng.randomize()
	var messageImage = "gameOver" + str(rng.randi_range(1, noGameOverMessages)) + ".png"
	message.texture = load("res://app/assets/sprites/ui/" + messageImage)
	
	$gameOver.add_child(message)
	$gameOver.visible = true
	$actors/player/attackSFX.play()


# Checks if gridPos is within the grid boundarys
func isWithinGrid(gridPos):
	if gridPos.x < gridSize.x && gridPos.x >= 0 && gridPos.y < gridSize.y && gridPos.y >= 0:
		return true
	return false

# Collects potion on gridPos tile
func collectPotion(gridPos):
	for child in $actors.get_children():
		if world_to_map(child.position) == gridPos:
			$potionPickupSFX.play()
			collectedPotion = child.effect
			grid[gridPos.x][gridPos.y] = null
			child.queue_free()
			break


func updateChildPos(child):
	var gridPos = world_to_map(child.position)
	if gridPos in steamLocations:
		grid[gridPos.x][gridPos.y] = 8
	else:
		grid[gridPos.x][gridPos.y] = null
	
	var newGridPos = gridPos + child.moveDir
	grid[newGridPos.x][newGridPos.y] = child.type
	
	var targetPos = map_to_world(newGridPos)
	return targetPos
	
	return(Vector2(0,0))


func findNpcInRange(child):
	var childPos = world_to_map(child.position)
	
	for x in range(childPos.x, gridSize.x):
		if $wallTiles.get_cellv(Vector2(x, childPos.y)) > -1 || grid[x][childPos.y] == 8:
			break
		elif grid[x][childPos.y] in [4,7]:
			return(Vector2(1, 0))
	
	for x in range(childPos.x, 0, -1):
		if $wallTiles.get_cellv(Vector2(x, childPos.y)) > -1 || grid[x][childPos.y] == 8:
			break
		elif grid[x][childPos.y] in [4,7]:
			return(Vector2(-1, 0))	
	
	for y in range(childPos.y, gridSize.y):
		if $wallTiles.get_cellv(Vector2(childPos.x, y)) > -1 || grid[childPos.x][y] == 8:
			break
		elif grid[childPos.x][y] in [4,7]:
			return(Vector2(0, 1))	
	
	for y in range(childPos.y, 0, -1):
		if $wallTiles.get_cellv(Vector2(childPos.x, y)) > -1 || grid[childPos.x][y] == 8:
			break
		elif grid[childPos.x][y] in [4,7]:
			return(Vector2(0, -1))

	return(null)


func _process(delta):
	if Input.is_action_just_pressed("restart") && !self.is_queued_for_deletion():
		get_node("/root/levelHandeler/bgMusic").volume_db = -2
		get_parent().get_node("nextLevel").nextLevel(get_parent().currentLevel, self)
