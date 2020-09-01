extends KinematicBody2D
 
var MAX_SPEED = 195 #150
var max_move_speed = MAX_SPEED
var low_dam = 0.5
var high_dam = 1
var damage = (low_dam + high_dam)/2
var speed_decrease = 20
onready var z_left = get_tree().current_scene
export var MAX_HEALTH = 100
export var health = 100
var alive = true

var dead_body = preload("res://Enemy/D_Zombie.tscn").instance()
onready var raycast = $RayCast2D
onready var anim = $AnimatedSprite

onready var anim_hit = $Hit
var tim_hit_past = 0
var player = null


func _ready():
	add_to_group("zombies")
	anim.play()
	anim_hit.play()
	
 
func _physics_process(delta):

	if not alive:
		queue_free()
		return
	if OS.get_ticks_msec() - tim_hit_past > 1000:
		anim_hit.visible = false
	#return
	if player == null:
		return
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_slide(vec_to_player * MAX_SPEED)
	if raycast.is_colliding():
		MAX_SPEED = max_move_speed
		var coll = raycast.get_collider()
		if coll.name == "Player":
			damage = get_rand_num(low_dam,high_dam)
			coll.be_damaged(damage)
		
		

func get_rand_num(s,e):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(s,e)
	#print(my_random_number)
	return my_random_number

func knifed(dir):
	killed(50)

func killed(damage):
	$Hit.position.y = get_rand_num(-15,12)
	anim_hit.visible = true
	tim_hit_past = OS.get_ticks_msec()
	if MAX_SPEED > max_move_speed/2:
		MAX_SPEED -= speed_decrease
	health -= damage
	if health <= 0:
		anim.visible = false
		#$d_b.visible = true
		anim_hit.visible = false
		$CollisionShape2D.disabled = true
		get_tree().current_scene.add_child(dead_body)
		dead_body.global_position = global_position
		dead_body.rotation = rotation
		dead_body.get_node("CollisionShape2D").disabled = true
		z_left.z_left -=1
		$Detec.bye()
		alive = false
		return true
	return false	
 
func set_player(p):
	player = p
