extends CanvasLayer



func _on_Button_pressed():
	$AudioStreamPlayer2D.play()




func _on_AudioStreamPlayer2D_finished():
	$BGM.stop()
	get_tree().change_scene("res://World/World.tscn")


func _on_Button2_pressed():
	get_tree().quit()
