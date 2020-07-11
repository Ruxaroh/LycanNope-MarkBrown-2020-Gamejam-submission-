tool
extends Sprite

func _process(delta):
	if Engine.editor_hint:
		var spriteTexture
		var potionType = get_parent().effect
		match potionType:
			_:
				spriteTexture = load("res://app/assets/sprites/tiles/potionTransparent.png")
				continue
			1:
				spriteTexture = load("res://app/assets/sprites/tiles/potionRed.png")
				continue
			2:
				spriteTexture = load("res://app/assets/sprites/tiles/potionGreen.png")
				continue
			3:
				spriteTexture = load("res://app/assets/sprites/tiles/potionWhite.png")
				continue
		set_texture(spriteTexture)
