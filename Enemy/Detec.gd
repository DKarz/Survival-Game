extends Area2D

func bye():
	queue_free()

func _on_Detec_body_entered(body):
	if "Player" in body.name:
		$CollisionShape2D/AudioStreamPlayer2D.play()


func _on_Detec_body_exited(body):
	if "Player" in body.name:
		$CollisionShape2D/AudioStreamPlayer2D.stop()
