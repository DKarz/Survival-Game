extends StaticBody2D



func _physics_process(delta):
	if not $Area2D/Czech_Hdgehog_B.visible:
		queue_free()


