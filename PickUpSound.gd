extends Node2D

func _ready():
	$AudioStreamPlayer2D.play()


func _on_AudioStreamPlayer2D_finished():
	queue_free()
