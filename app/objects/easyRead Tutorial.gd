extends Sprite


func _process(delta):
	if Input.is_action_just_pressed("toggleTutorial") && !self.is_queued_for_deletion():
		if (self.visible):
			self.hide()
		else:
			self.show()
