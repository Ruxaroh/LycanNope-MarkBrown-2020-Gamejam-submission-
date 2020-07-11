extends "res://app/objects/entities/npcs/scripts/npc.gd"

# red npc's will move vertically
func _ready():
	moveDir = Vector2(0, 1)
	._ready()

# Set shirt colour to red
func setShirtColour():
	var spriteTexture
	if enemy:
		spriteTexture = load("res://app/assets/sprites/npcs/npcRed/npcRedEnemy0.png")
	else:
		spriteTexture = load("res://app/assets/sprites/npcs/npcRed/npcRed0.png")
	$npcSprite.set_texture(spriteTexture)


func _on_moveTimer_timeout():
	move()
