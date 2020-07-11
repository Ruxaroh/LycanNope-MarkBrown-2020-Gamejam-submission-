extends KinematicBody2D


export var effect: int = 0
var type
var spriteTexture


# Called when the node enters the scene tree for the first time.
func _ready():
	type = 3
	if effect == 1:
		spriteTexture = load("res://app/assets/sprites/tiles/potionRed.png")
	elif effect == 2:
		spriteTexture = load("res://app/assets/sprites/tiles/potionGreen.png")
	elif effect == 3:
		spriteTexture = load("res://app/assets/sprites/tiles/potionGrey.png")
	else:
		spriteTexture = load("res://app/assets/sprites/tiles/potionTransparent.png")
	$Sprite.set_texture(spriteTexture)
