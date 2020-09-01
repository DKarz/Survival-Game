extends CanvasLayer

func _ready():
	set_label()

func set_label():
	var wave = Shop.get_node("STATUS").wave
	$Label2.text = "You survived " +str(wave) + " waves"

func _on_Button_pressed():
	Shop.unbought()
	get_tree().change_scene("res://World/World.tscn")
	
	



func _on_Timer_timeout():
	get_tree().reload_current_scene()
	queue_free()
