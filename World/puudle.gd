extends Area2D



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.MAX_SPEED /= 4
		body.in_puddle = true
		#$AudioStreamPlayer2D.play()


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.MAX_SPEED *= 4
		body.in_puddle = false
		body.get_node("Puddle").stop()
		body.get_node("Walk").play()
		#$AudioStreamPlayer2D.stop()
