extends Camera2D

#start(duration = 0.2, frequency = 15, amplitude = 16, priority = 0):
func wolfAttack():
	$ScreenShake.start(1, 15, 16, 1)

func step():
	$ScreenShake.start(0.1, 4, 3, 0)

func transform():
	$ScreenShake.start(1, 30, 4, 1)
