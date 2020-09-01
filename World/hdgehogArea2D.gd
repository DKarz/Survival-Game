extends Area2D

var health = 300
var player_here = false
var zombies_in_area = 0
var coef = 0.8

func _physics_process(delta):
	$Progress.value = health
	health -= zombies_in_area * coef
	if health <= 0:
		$Czech_Hdgehog_B.visible = false

func _on_Area2D_body_entered(body):
	if "Zombi" in body.name:
		zombies_in_area += 1
#	elif "Player" in body.name:
#		player_here = true

func _on_Area2D_body_exited(body):
	
	if "Zombi" in body.name:
		zombies_in_area -= 1
#	elif "Player" in body.name:
#		player_here = false
