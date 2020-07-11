tool
extends AnimatedSprite

func _process(delta):
	if Engine.editor_hint:
		var npcType = get_parent().npcType
		match npcType:
			0:
				play("green")
				continue
			1:
				play("red")
				continue
			2:
				play("blue")
				continue
