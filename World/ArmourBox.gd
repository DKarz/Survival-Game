extends StaticBody2D

func _physics_process(delta):
	if $Area2D/CollisionShape2D.disabled:
		
		queue_free()
