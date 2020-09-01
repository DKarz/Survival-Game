extends Area2D



func _on_Sound_body_entered(body):
	if "Player" in body.name:
		$AudioStreamPlayer2D.play()


func _on_Sound_body_exited(body):
	if "Player" in body.name:
		$AudioStreamPlayer2D.stop()
