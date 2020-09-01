extends RigidBody2D
var player = null
var posi = Vector2()
var dist = 0
var damage = 0
var dmg_range = [0,0.00001]
var status_killed = false
func get_rand_num(s,e):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(s,e)
	#print(my_random_number)
	return my_random_number
	
func _physics_process(delta):
	if global_position.distance_to(posi) > dist:
		queue_free()

func _on_Bullet_body_shape_entered(body_id, body, body_shape, local_shape):
	#print("col")
	if "Zombi" in body.name:
		damage = get_rand_num(dmg_range[0],dmg_range[1])
		status_killed = body.killed(damage)
		if status_killed:
			player.balance += player.bal_add
			player.zombies_killed +=1
	queue_free()
