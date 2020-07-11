extends "res://app/objects/entities/npcs/scripts/npc.gd"

# green npc's will not move
func _ready():
	moveDir = Vector2(0, 0)
	._ready()

func move():
	pass

# Set shirt colour to green
func setShirtColour():
	var spriteTexture
	if enemy:
		spriteTexture = load("res://app/assets/sprites/npcs/npcGreen/npcGreenEnemy0.png")
	else:
		spriteTexture = load("res://app/assets/sprites/npcs/npcGreen/npcGreen0.png")
	$npcSprite.set_texture(spriteTexture)


func _on_moveTimer_timeout():
	move()
