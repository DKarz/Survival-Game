extends Area2D

func get_rand(s,e):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = int(rng.randf_range(s,e))
	#print(my_random_number)
	return my_random_number


func _on_Area2D_body_entered(body):
	var p_plus = get_rand(10,30)
	var r_plus = get_rand(10,30)
	#print(p_plus, r_plus)
	body.pistol_ch[1] += p_plus
	body.rifle_ch[1] += r_plus
	body.change_weapon()
	body.change_weapon()
	var text_str = ""
	var offset_ = Vector2(0,0)
	text_str += str(p_plus) + " pistol bullets\n"
	text_str += str(p_plus) + " pistol bullets\n"
	p_plus = get_rand(0,10)
	r_plus = get_rand(0,10)
	if p_plus >= 6:
		p_plus = int(get_rand(1.01,3.25))
		text_str += str(p_plus) + " bandages\n"
		offset_.y +=5
		body.bandages_left += p_plus
	if r_plus >= 7:
		r_plus = int(get_rand(1.01,3.25))
		text_str += str(r_plus) + " bombs\n"
		offset_.y +=5
		body.bombs_left += r_plus
		
	r_plus = get_rand(0,10)
	
	if r_plus >= 7:
		r_plus = int(get_rand(2.01, 6.999))
		text_str += str(r_plus) + " traps\n"
		offset_.y +=5
		body.czchs_left += r_plus
		
	var label = load("res://World/InfoLabel.tscn").instance()
	get_tree().current_scene.add_child(label)
	label.global_position = global_position + Vector2(25,0)
	label.get_node("RichTextLabel").text = text_str
	
	var sound = load("res://PickUpSound.tscn").instance()
	get_tree().current_scene.add_child(sound)
	
	$CollisionShape2D.disabled = true
	
