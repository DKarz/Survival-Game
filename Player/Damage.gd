extends Area2D

var to_blow = false

var to_damage = []
var zomd_killed = false
var player = null
var player_set = false
var fin = false
var sound =true
func get_rand(s,e):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = int(rng.randf_range(s,e))
	#print(my_random_number)
	return my_random_number

func _physics_process(delta):
	
	if not to_blow:
		return
	$BlowAnim.visible = true
	$BlowAnim.play()
	if sound:
		$Sound.play()
		sound = false
	
	for Body in to_damage:
		if Body.name == "Player":
			Body.be_damaged(get_rand(50,110))
		else:
			zomd_killed = Body.killed(get_rand(60,110))
			if zomd_killed and player != null:
				player.balance += player.bal_add
				player.zombies_killed += 1
	if player != null:
		player.balance_label.text = "Balance  "  +str(player.balance) + " $\n"
		player.balance_label.text += "Killed " + str(player.zombies_killed)
	



func _on_Damage_body_entered(body):
	to_damage.append(body)
	#print(to_damage)


func _on_Damage_body_exited(body):
	if not player_set and body.name == "Player":
		player = body
		player_set = true
	to_damage.remove(to_damage.find(body))
	#print(to_damage)


func _on_AnimatedSprite_animation_finished():
	
	$CollisionShape2D.disabled = true
	


func _on_Sound_finished():
	fin = true
