extends Area2D



func _on_Area2D_body_entered(body):
	$Sprite.modulate.a = 0.5


func _on_Area2D_body_exited(body):
	$Sprite.modulate.a = 1
