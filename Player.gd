extends KinematicBody2D


export var ACCELERATION = 500 
export var MAX_SPEED = 400 #400
export var FRICTION = 1500
export var MAX_HEALTH = 100
export var health = 100
var velocity = Vector2()
var look_vec = Vector2()

onready var shot_sound = $ShotSound
onready var legs_anim = $ANIMLEGS
onready var body_anim = $ANIMBODY
onready var shot_effect = $ShotEffect

var pistol_ch = [7, 200, 7, 50, 70, 1000, 450] #[7, 200, 50, 70, 1] = 7/200, 7 bul in mag,[50,70], 1 milesec
var rifle_ch = [24, 48, 24, 20, 45, 270, 900]
var curr_wep = pistol_ch
var weapon = "pistol"
var last_shot_time = 0
var reloading = false
var damage = 55
var time_to_reload = 1200
var enemy_status = false
var set_trap = 0
var setting_trap = false
var bombs_left = 1 # 1
var bandages_left = 1
var czchs_left = 5
var balance = 500
var bal_add = 20
var zombies_killed = 0
var bull_speed = 1000
var time_MSG_gone = 0
var chosen_item = "bandage"
var have_rifle = false #false
var have_knife = false #false
var have_impr_bombs = false
var to_set_trap = 125
var in_puddle = false
var walk_playing = false
var mobile = Shop.get_node("STATUS").mobile
var cheat = 0
var cheat1 = 0
var alive = true
onready var health_bar = get_tree().current_scene.get_node("CanvasLayer/Node2D/HealthBar")
onready var bullets_label = get_tree().current_scene.get_node("CanvasLayer/Bullets")
onready var balance_label = get_tree().current_scene.get_node("CanvasLayer/Balance")
onready var MSG_label = get_tree().current_scene.get_node("CanvasLayer/MSG")
onready var pistol_ico = get_tree().current_scene.get_node("CanvasLayer/Wep_p")
onready var rifle_ico = get_tree().current_scene.get_node("CanvasLayer/Wep_r")
onready var inven = get_tree().current_scene.get_node("CanvasLayer/Inventory")
onready var joystick = get_tree().current_scene.get_node("CanvasLayer/Joystick/TouchScreenButton")
onready var joystick2 = get_tree().current_scene.get_node("CanvasLayer/Joystick2/TouchScreenButton")
onready var raycast = $RayCast2D
onready var bullet = preload("res://Player/Bullet.tscn")
onready var coll = raycast.get_collider()
onready var curr_ico = pistol_ico

func test():
	health = 10000
	balance = 10000000
	MAX_SPEED = 1400
	have_knife = true
	have_rifle = true
	bombs_left = 10

func test1():
	health = 10000
	balance = 10000000
	MAX_SPEED = 400
	have_knife = true
	have_rifle = true
	bombs_left = 10
	
	
func _ready():
	#test()
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	var shot_sound = $ShotSound
	shot_sound.stream.loop = false
	legs_anim.playback_speed = 30
	body_anim.playback_speed = 30
	bullets_label.text = str(pistol_ch[0]) + " / " + str(pistol_ch[1])
	shot_effect.visible = false
	pistol_ico.visible = true
	rifle_ico.visible = false
	balance_label.text = "Balance  0 $"


func count_cheat():
	if Input.is_action_just_pressed("cheat"):
		cheat += 1
		if cheat > 20:
			test()
			cheat = -100
	elif Input.is_action_just_pressed("cheat1"):
		cheat1 += 1
		if cheat1 > 20:
			test1()
			cheat1 = -100
	
#func _input(event):
#	if event is InputEventScreenDrag:
#		var movement = event.relative
#		#print("Move", movement)
#		var s1 = 1
##		var s2 = 1
##		if (-1.5 <= global_rotation and global_rotation  <= -3) or (1.5 <= global_rotation and  global_rotation<= 3):
##			s2 = -1
#		if 0 <= global_rotation and global_rotation  <= 3:
#			s1 = -1
#		print("GR   ", global_rotation_degrees, "    ", global_rotation)
#		global_rotation += (s1 * movement.x )/360
	
func _physics_process(delta):
	if not alive:
		return
	health_bar.value = health
	balance_label.text = "Balance  "  +str(balance) + " $\n"
	balance_label.text += "Killed " + str(zombies_killed)
	inven.get_node("Amount1").text = str(bandages_left)
	inven.get_node("Amount2").text = str(bombs_left)
	inven.get_node("Amount3").text = str(czchs_left)
	
	if Shop.get_node("STATUS").buying:
		return
	#print(position)
	if OS.get_ticks_msec() - last_shot_time >= 300:
		shot_effect.visible = false

	if reloading:
		var _time = OS.get_ticks_msec() - last_shot_time
		curr_ico.value = _time
		if _time >= time_to_reload:
			reloading = false
			$ReloadSound.stop()
			curr_ico.value = time_to_reload
			if weapon == 'rifle':
				$Body_rifle.visible = true
				$reloading_rifle.visible = false
			else:
				$Body.visible = true
				$reloading_pistol.visible = false
	else:
		bullets_label.text = str(curr_wep[0]) + " / " + str(curr_wep[1])
		
		
	
	move_state(delta)
	
	
	
	to_aim()
	if Input.is_action_just_pressed("reload"):
		reload()
	if weapon == "pistol" and Input.is_action_just_pressed("shoot"):
		to_shoot()
	if weapon == "rifle" and Input.is_action_pressed("shoot"):
		to_shoot()
	if Input.is_action_just_pressed("chng_wep"):
		change_weapon()
	if Input.is_action_just_pressed("flashlight"):
		$Light2D2.enabled = not $Light2D2.enabled
	if Input.is_action_just_pressed("knife_attack"):
		knife_attack()
	items()
	trap()
	if OS.get_ticks_msec() - time_MSG_gone > 2000:
		MSG_label.text = ""
	count_cheat()

func to_buy():
	pass


func items():
	
	if Input.is_action_just_pressed("Item1"):
		chosen_item = "bandage"
		inven.on_val_updated(1,0,0)
		
	elif Input.is_action_just_pressed("Item2"):
		chosen_item = "bomb"
		inven.on_val_updated(0,1,0)
		
	elif Input.is_action_just_pressed("Item3"):
		chosen_item = "czch"
		inven.on_val_updated(0,0,1)

func knife_attack():
	
	
	if reloading:
		MSG_label.text = "Cannot use knife while reloading"
		time_MSG_gone = OS.get_ticks_msec()
		return
	if not have_knife:
		MSG_label.text = "You do not have knife"
		time_MSG_gone = OS.get_ticks_msec()
		return
	var coll = $KnifeAttackRay.get_collider()
	if $KnifeAttackRay.is_colliding() and coll.has_method("knifed"):
		coll.knifed(look_vec)
	if $KnifeAttackRay.is_colliding() and "HdgehogWood" in coll.name:
		coll.get_node("Area2D").health -= 50
	
	$Body.visible = false
	$Body_rifle.visible = false
	$knife_attack.visible = true
	$knife_attack.play()
	
func get_rand_num(s_,e_):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(s_,e_)
	#print(my_random_number)
	return my_random_number
	
func trap():
	$Prog.global_rotation = 0
	if chosen_item == "bomb" and bombs_left <= 0:
		MSG_label.text = "No bombs left"
		time_MSG_gone = OS.get_ticks_msec()
		return
	if chosen_item == "czch" and czchs_left <= 0:
		MSG_label.text = "No traps left"
		time_MSG_gone = OS.get_ticks_msec()
		return
	if chosen_item == "bandage" and (bandages_left <= 0 or health == MAX_HEALTH):
		return
	$Prog/Progress.value = set_trap
	if Input.is_action_just_pressed("set_trap"):
		setting_trap = true
		set_trap = 0
		$Prog/Progress.visible = true
		
	if setting_trap:
		set_trap += 0.7
		#print("SET TRAP:  ",set_trap)
	if Input.is_action_just_released("set_trap"):
		
		setting_trap = false
		set_trap = 0
		$Prog/Progress.visible = false
	if set_trap >= to_set_trap:
		if chosen_item == "bomb":
			bombs_left -=1
			
			var settet_trap = look_vec
			var my_trap = load("res://Player/Bomb.tscn").instance()
			if have_impr_bombs:
				my_trap.improve()
			get_tree().current_scene.add_child(my_trap)
			my_trap.global_position = global_position + settet_trap.normalized()*80
			setting_trap = false
			set_trap = 0
		elif chosen_item == "bandage":
			be_damaged(-50)
			setting_trap = false
			set_trap = 0
			bandages_left -=1
		elif chosen_item == "czch":
			var settet_trap = look_vec
			var my_trap = load("res://World/HdgehogWood.tscn").instance()
			get_tree().current_scene.add_child(my_trap)
			my_trap.global_position = global_position + settet_trap.normalized()*80
			setting_trap = false
			set_trap = 0
			czchs_left -=1
		$Prog/Progress.visible = false	
			
func change_weapon():
	
	if reloading:
		MSG_label.text = "Cannot change weapon while reloading"
		time_MSG_gone = OS.get_ticks_msec()
		return
	if not have_rifle:
		MSG_label.text = "You do not have second weapon"
		time_MSG_gone = OS.get_ticks_msec()
		return
	$Body.visible = not $Body.visible
	$Body_rifle.visible = not $Body_rifle.visible
	if $Body_rifle.visible:
		curr_ico = rifle_ico
		pistol_ch = curr_wep
		weapon = "rifle"
		curr_wep = rifle_ch
		pistol_ico.visible = false
		rifle_ico.visible = true
		shot_effect.position.x +=23
		$Aim.position.x +=23
		#$BulletPoint.position.x +=24.487
	else:
		curr_ico = pistol_ico
		rifle_ch = curr_wep
		weapon = "pistol"
		curr_wep = pistol_ch
		pistol_ico.visible = true
		rifle_ico.visible = false
		shot_effect.position.x -=23
		$Aim.position.x -=23
		#$BulletPoint.position.x -=24.487
	bullets_label.text = str(curr_wep[0]) + " / " + str(curr_wep[1])

func animate(state):
	if state == "move":
		legs_anim.play("move_legs")
		
		if weapon == "pistol":
			body_anim.playback_speed = 30
			body_anim.play("move")
		else:
			body_anim.playback_speed = 2
			body_anim.play("move_rifle")
	elif state == "idle":
		legs_anim.stop()
		if weapon == "pistol":
			body_anim.playback_speed = 11
		else:
			body_anim.playback_speed = 2
		
func reload():
	
	if curr_wep[0] == curr_wep[2]:
		MSG_label.text = "Full"
		time_MSG_gone = OS.get_ticks_msec()
		return
	$ReloadSound.play()
	if weapon == "rifle":
		$Body_rifle.visible = false
		$reloading_rifle.visible = true
		$reloading_rifle.play()
	else:
		$Body.visible = false
		$reloading_pistol.visible = true
		$reloading_pistol.play()
	bullets_label.text = str(curr_wep[0]) + " / " + str(curr_wep[1]) +"\nRELOADING"
	if curr_wep[1] >= curr_wep[2]:
		#print("R")
		curr_wep[1] -= curr_wep[2] - curr_wep[0]
		curr_wep[0] += curr_wep[2] - curr_wep[0]
	else:
		curr_wep[0] += curr_wep[1]
		if curr_wep[0] >= curr_wep[2]:
			curr_wep[1] = curr_wep[0] % curr_wep[2]
			curr_wep[0] -= curr_wep[1]
		else:
			curr_wep[1] = 0
	
	reloading = true
	last_shot_time = OS.get_ticks_msec()

func to_shoot():
	
	
	if reloading:
		if OS.get_ticks_msec() - last_shot_time >= time_to_reload:
			reloading = false
		return
	else:
		bullets_label.text = str(curr_wep[0]) + " / " + str(curr_wep[1])
	
	if OS.get_ticks_msec() - last_shot_time >= curr_wep[5]:
		if curr_wep[0] <= 0:
			MSG_label.text = "Reload"
			time_MSG_gone = OS.get_ticks_msec()
			$TriggerSound.play()
			return
		shot_effect.visible = true
		last_shot_time = OS.get_ticks_msec()
		if weapon == "rifle":
			shot_sound.play()
		else:
			$PisAu.play()
		curr_wep[0] -=1
		coll = raycast.get_collider()
		
		
		var bul_ins = bullet.instance()
		bul_ins.position = $BulletPoint.global_position
		bul_ins.rotation_degrees = rotation_degrees
		bul_ins.dmg_range[0] = curr_wep[3]
		bul_ins.dmg_range[1] = curr_wep[4]
		bul_ins.player = self
		bul_ins.posi = global_position
		bul_ins.dist = curr_wep[6]
		#print(rotation)
		bul_ins.apply_impulse(Vector2(), Vector2(bull_speed, 0).rotated(rotation))
		get_tree().current_scene.add_child(bul_ins)
		
		
#		if raycast.is_colliding() and coll.has_method("killed"):
#			enemy_status = coll.killed(damage)
#			if enemy_status:
#				balance += 20
#				zombies_killed += 1
#				balance_label.text = "Balance  "  +str(balance) + " $\n"
#				balance_label.text += "Killed " + str(zombies_killed)
		bullets_label.text = str(curr_wep[0]) + " / " + str(curr_wep[1])
		


func to_aim():
	if not mobile:
		look_vec = get_global_mouse_position() - global_position
		global_rotation = atan2(look_vec.y, look_vec.x)
	else:
		
		look_vec = joystick2.get_value()
		global_rotation = atan2(look_vec.y, look_vec.x)
			
		
	
func set_msg(text_):
	MSG_label.text = text_
	time_MSG_gone = OS.get_ticks_msec() + 5000
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if mobile:
		input_vector = joystick.get_value()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector*MAX_SPEED, ACCELERATION*delta)
		animate("move")
		if setting_trap:
			setting_trap = false
			set_trap = 0
			$Prog/Progress.visible = false
			MSG_label.text = "Cannot do it while moving"
			time_MSG_gone = OS.get_ticks_msec()
		if not walk_playing:
			if not in_puddle:
				$Walk.play()
			else:
				$Puddle.play()
			walk_playing = true
	else:
		$Walk.stop()
		$Puddle.stop()
		walk_playing = false
		animate("idle")
		velocity = Vector2()
		
	
	
	velocity = move_and_slide(velocity)

func be_damaged(damage):
	health -= damage
	if health <= 0:
		var new_game = load("res://Restart.tscn").instance()
		get_tree().current_scene.add_child(new_game)
		alive = false
		#get_tree().reload_current_scene()
		
#func get_health():
#	return [health, MAX_HEALTH]

func improve_health(value):
	var bar_health_node = get_tree().current_scene.get_node("CanvasLayer/Node2D")
	bar_health_node.scale.x *= 1.2
	MAX_HEALTH += value
	health_bar.max_value = MAX_HEALTH
	health = MAX_HEALTH

func _on_knife_attack_animation_finished():
	
	$knife_attack.visible = false
	$knife_attack.stop()
	if weapon == "rifle":
		$Body_rifle.visible = true
	else:
		$Body.visible = true


func _on_TriggerSound_finished():
	$TriggerSound.stop()


func _on_PisAu_finished():
	$PisAu.stop()
