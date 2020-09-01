extends Area2D



func _on_Detection_body_entered(body):
	
	$CollisionShape2D.disabled = true
	#queue_free()
