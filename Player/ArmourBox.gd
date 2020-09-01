extends StaticBody2D






func _on_Area2D_area_entered(area):
	print("hellol")


func _on_Area2D_body_entered(body):
	print("hellol")


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	print("1")


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	print('2')
