extends Area2D




var player_here = false
var player = null

func _ready():
	$AnimatedSprite.play()

func get_rand_num(s,e):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(s,e)
	#print(my_random_number)
	return my_random_number

func _process(delta):
	
	$AnimatedSprite.position.x += get_rand_num(-1.3001,1.3001)
	$AnimatedSprite.position.x += get_rand_num(-1.3001,1.3001)
	if not player_here:
		return
	if Input.is_action_just_pressed("Buy"):
		#print("hhh")
		
		Shop.get_node("STATUS").buying = true
		Shop.get_node("STATUS").player = player
		Shop.get_node("STATUS").open = true
		Shop.set_all_vis()

func _on_Area2D_body_entered(body):
	#print("hew")
	player_here = true
	player = body
	body.set_msg("Press B to Buy")
	


func _on_Area2D_body_exited(body):
	Shop.set_all_vis(false)
	#print("Buey")
	player_here = false
	player.set_msg("")
	player = null


func _on_Sound_body_exited(body):
	pass # Replace with function body.
