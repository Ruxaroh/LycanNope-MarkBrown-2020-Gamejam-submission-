extends "res://app/objects/entities/npcs/scripts/npc.gd"

# red npc's will move horizontally
func _ready():
	moveDir = Vector2(1, 0)
	._ready()

# Set shirt colour to blue
func setShirtColour():
	var spriteTexture
	if enemy:
		spriteTexture = load("res://app/assets/sprites/npcs/npcBlue/npcBlueEnemy0.png")
	else:
		spriteTexture = load("res://app/assets/sprites/npcs/npcBlue/npcBlue0.png")
	$npcSprite.set_texture(spriteTexture)


func _on_moveTimer_timeout():
	move()
