extends Node2D


var x_ = 0
var y_ = 0
var z_left = 0
var wave = 0
var rotate_arr = true
var wave_break = false
var wave_finished = true
var time = 0
var zomb =   [0, 2, 3, 5, 5, 5, 6, 6, 7, 7, 8, 8, 9, 10, 11, 12, 13, 14]
var zomb_r = [0, 0, 0, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 5 , 6 ,7 , 8, 9, 10,11]
var z1 = 0
var z2 = 0
var zomb_imp = false

func generate_wave():
	wave += 1
	Shop.get_node("STATUS").wave = wave
	if wave >= len(zomb):
		z1 = 17
		z2 = 17
		zomb_imp = true
	else:
		z1 = zomb[wave]
		z2 = zomb_r[wave]
	
	
	z_left = z1 + z2
	for z in range(z1):
		x_ = get_rand(-1705,4876)
		y_ = get_rand(-1596,1848)
		while $Player.global_position.distance_to(Vector2(x_,y_)) < 400:
			x_ = get_rand(-1705,4876)
			y_ = get_rand(-1596,1848)
		var zombi = load("res://Enemy/Zombie.tscn").instance()
		if zomb_imp:
			zombi.MAX_SPEED * pow(1.01, wave)
			zombi.low_dam * pow(1.01, wave)
			zombi.high_dam * pow(1.01, wave)
		zombi.player = $Player
		add_child(zombi)
		zombi.global_position = Vector2(x_,y_)
	for z in range(z2):
		x_ = get_rand(-1705,4876)
		y_ = get_rand(-1596,1848)
		while $Player.global_position.distance_to(Vector2(x_,y_)) < 400:
			x_ = get_rand(-1705,4876)
			y_ = get_rand(-1596,1848)
		var zombi = load("res://Enemy/ZombiRunner.tscn").instance()
		
		zombi.player = $Player
		add_child(zombi)
		zombi.global_position = Vector2(x_,y_)
	for arbox in range(0, 2):
		var arbox_ = load("res://Player/ArmourBox.tscn").instance()
		add_child(arbox_)
		x_ = get_rand(-1705* 1.1,4876* 1.1)
		y_ = get_rand(-1596* 1.1,1848* 1.1)
		arbox_.global_position = Vector2(x_,y_)
	for heal_ in range(0, 4):
		var heal__ = load("res://World/Heal.tscn").instance()
		add_child(heal__)
		x_ = get_rand(-1705 * 1.1,4876* 1.1)
		y_ = get_rand(-1596* 1.1,1848* 1.1)
		heal__.global_position = Vector2(x_,y_)

func get_rand(s,e):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = int(rng.randf_range(s,e))
	#print(my_random_number)
	return my_random_number

func generate_objects():
	for tree_ in range(0, 50):
		var tree = load("res://World/Tree.tscn").instance()
		add_child(tree)
		x_ = get_rand(-1705* 1.1,4876* 1.1)
		y_ = get_rand(-1596* 1.1,1848* 1.1)
		tree.global_position = Vector2(x_,y_)
	
	for lamp_ in range(0, 4):
		var lamp__ = load("res://World/Flashlight.tscn").instance()
		add_child(lamp__)
		x_ = get_rand(-1705/2* 1.1,4876/2* 1.1)
		y_ = get_rand(-1596/2* 1.1,1848/2* 1.1)
		lamp__.global_position = Vector2(x_,y_)
		
	for arbox in range(0, 4):
		var arbox_ = load("res://Player/ArmourBox.tscn").instance()
		add_child(arbox_)
		x_ = get_rand(-1705* 1.1,4876* 1.1)
		y_ = get_rand(-1596* 1.1,1848* 1.1)
		arbox_.global_position = Vector2(x_,y_)
	for heal_ in range(0, 4):
		var heal__ = load("res://World/Heal.tscn").instance()
		add_child(heal__)
		x_ = get_rand(-1705 * 1.1,4876* 1.1)
		y_ = get_rand(-1596* 1.1,1848* 1.1)
		heal__.global_position = Vector2(x_,y_)
	for hdge_ in range(0, 20):
		var hdge = load("res://World/Hdgehog.tscn").instance()
		add_child(hdge)
		x_ = get_rand(-1705* 1.1,4876* 1.1)
		y_ = get_rand(-1596* 1.1,1848* 1.1)
		hdge.global_position = Vector2(x_,y_)
	for tv_ in range(0,3):
		var tv = load("res://World/TV.tscn").instance()
		add_child(tv)
		x_ = get_rand(-1705/1.5,4876/1.5)
		y_ = get_rand(-1596/2,1848/2)
		tv.global_position = Vector2(x_,y_)
		tv.rotation = int(fmod(abs(int(x_)),360))
	
	for paddle in range(0,15):
		var puddle = load("res://World/Paddle.tscn").instance()
		add_child(puddle)
		x_ = get_rand(-1705* 1.3,4876* 1.3)
		y_ = get_rand(-1596* 1.3,1848* 1.3)
		puddle.global_position = Vector2(x_,y_)
		



func arrow_rotate():
	var look_vec = -$TheShop.global_position + $Player.global_position
	$CanvasLayer/DirShop.global_rotation = atan2(look_vec.y, look_vec.x)

func reload():
	get_tree().reload_current_scene()
	
func _ready():
	
	if not Shop.get_node("STATUS").mobile:
		$CanvasLayer/Joystick.visible = false
		$CanvasLayer/TouchScreenButton.visible = false
		$CanvasLayer/TouchScreenButton2.visible = false
		$CanvasLayer/TouchScreenButton3.visible = false
		$CanvasLayer/TouchScreenButton4.visible = false
		$CanvasLayer/TouchScreenButton5.visible = false
	#return
	generate_objects()



func get_shop():
	arrow_rotate()
	x_ = get_rand(-1705/2.5,4876/2.5)
	y_ = get_rand(-1596/2.5,1848/2.5)
	$TheShop.global_position = Vector2(x_,y_)
	$CanvasLayer/DirShop.visible = true

func hide_shop():
	$TheShop.global_position = Vector2(-5000,-5000)
	$CanvasLayer/DirShop.visible = false
	
func _physics_process(delta):
	#print(delta)
#	print("Time left ", $Timer.time_left)
#	print(z_left)
#	print($TheShop.position)
	if z_left <= 0 and not wave_break:
		start_break()
		
	if rotate_arr:
		if int($Timer.time_left) <= 5:
			$CanvasLayer/WaveLabel.modulate = Color(1,0,0)
		$CanvasLayer/WaveLabel.text = str(int($Timer.time_left)) + " seconds left"
		arrow_rotate()

func start_break():
	rotate_arr = true
	wave_break = true
	get_shop()
	$Timer.start()

func _on_Timer_timeout():
	$CanvasLayer/WaveLabel.modulate = Color(1,1,1)
	Shop.get_node("STATUS").open = false
	Shop.set_all_vis(false)
	Shop.get_node("STATUS").buying = false
	rotate_arr = false
	wave_break = false
	generate_wave()
	$CanvasLayer/WaveLabel.text = "Wave " + str(wave)
	hide_shop()


func _on_BGM_finished():
	$BGM.play()
