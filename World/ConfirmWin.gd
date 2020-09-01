extends CanvasLayer

var status = false
var object_name = ""


func hide_(do = true):
	for node in get_children():
		node.visible = not do 
	

func _physics_process(delta):
	if not Shop.get_node("STATUS").open:
		hide_()
	
	if Shop.get_node("STATUS").prd_is_chosen:

		if Shop.get_node("STATUS").player.balance < Shop.get_node("STATUS").price:
			$Label.text = "Not enough money to buy\n"+ Shop.get_node("STATUS").product_name
			$RichTextLabel.text = "\nDescription\n" + Shop.get_node("STATUS").dis
			$Ico.texture = load(Shop.get_node("STATUS").path_to_ico)
			$ButtonYES.disabled = true
			
			return
		$ButtonYES.disabled = false
		$Label.text = "Are you sure you want to buy\n"+ Shop.get_node("STATUS").product_name
		$RichTextLabel.text = "\nDescription\n" + Shop.get_node("STATUS").dis
		$Ico.texture = load(Shop.get_node("STATUS").path_to_ico)
		
func _on_ButtonYES_pressed():
	buy(Shop.get_node("STATUS").product_name)
	status = true
	Shop.get_node("STATUS").prd_is_chosen = false
	Shop.get_node("STATUS").product_name = ""
	Shop.get_node("STATUS").bought = true
	Shop.get_node("STATUS").dis = ""
	Shop.get_node("STATUS").path_to_ico = ""
	Shop.get_node("STATUS").price = 0
	hide_()


func _on_ButtonNO_pressed():
	status = false
	Shop.get_node("STATUS").prd_is_chosen = false
	Shop.get_node("STATUS").product_name = ""
	Shop.get_node("STATUS").dis = ""
	Shop.get_node("STATUS").bought = false
	Shop.get_node("STATUS").path_to_ico = ""
	Shop.get_node("STATUS").price = 0
	hide_()
	
	
func buy(prd_name):
	$AudioStreamPlayer2D.play()
	Shop.get_node("STATUS").player.balance -= Shop.get_node("STATUS").price
	if prd_name == "Rifle":
		Shop.get_node("STATUS").player.have_rifle = true
		Shop.check_obj(0)
	elif prd_name == "Knife":
		Shop.get_node("STATUS").player.have_knife = true
		Shop.check_obj(1)
	elif prd_name == "Pistol Bullets":
		#print(2)
		var flag_ = false
		Shop.get_node("STATUS").player.pistol_ch[1] += 30
		if not Shop.get_node("STATUS").player.have_rifle:
			flag_ = true
			Shop.get_node("STATUS").player.have_rifle = true
		Shop.get_node("STATUS").player.change_weapon()
		Shop.get_node("STATUS").player.change_weapon()
		
	elif prd_name == "Rifle Bullets":
		#print(3)
		var flag_ = false
		Shop.get_node("STATUS").player.rifle_ch[1] += 24
		if not Shop.get_node("STATUS").player.have_rifle:
			flag_ = true
			Shop.get_node("STATUS").player.have_rifle = true
		Shop.get_node("STATUS").player.change_weapon()
		Shop.get_node("STATUS").player.change_weapon()
		if flag_:
			Shop.get_node("STATUS").player.have_rifle = false
	elif prd_name == "Bomb":
		Shop.get_node("STATUS").player.bombs_left += 1
		
	elif prd_name == "Hedgehog 3":
		Shop.get_node("STATUS").player.czchs_left += 3
	
	elif prd_name == "Bandages":
		Shop.get_node("STATUS").player.bandages_left += 1
		
	elif prd_name == "Speed Perk":
		Shop.get_node("STATUS").player.MAX_SPEED *= 1.3
		Shop.check_obj(2)
	elif prd_name == "Coin":
		Shop.get_node("STATUS").player.bal_add *= 2
		Shop.check_obj(3)
	elif prd_name == "Coins":
		Shop.get_node("STATUS").player.bal_add *= 4
		Shop.check_obj(4)
	elif prd_name == "Health l.1":
		Shop.get_node("STATUS").player.improve_health(100)
		Shop.check_obj(5)
	elif prd_name == "Health l.2":
		Shop.get_node("STATUS").player.improve_health(200)
		Shop.check_obj(6)
	elif prd_name == "Improved Bombs":
		Shop.get_node("STATUS").player.have_impr_bombs = true
		Shop.check_obj(7)
	elif prd_name == "Bandolier+":
		
		
		var flag_ = false
		Shop.get_node("STATUS").player.rifle_ch[2] += 10
		Shop.get_node("STATUS").player.piatol_ch[2] += 5
		if not Shop.get_node("STATUS").player.have_rifle:
			flag_ = true
			Shop.get_node("STATUS").player.have_rifle = true
		Shop.get_node("STATUS").player.change_weapon()
		Shop.get_node("STATUS").player.change_weapon()
		if flag_:
			Shop.get_node("STATUS").player.have_rifle = false
		
		Shop.check_obj(8)
	elif prd_name == "Armor-piercing bullets":
		
		var flag_ = false
		Shop.get_node("STATUS").player.rifle_ch[3] += 35
		Shop.get_node("STATUS").player.rifle_ch[4] += 35
		Shop.get_node("STATUS").player.pistol_ch[3] += 35
		Shop.get_node("STATUS").player.pistol_ch[4] += 35
		if not Shop.get_node("STATUS").player.have_rifle:
			flag_ = true
			Shop.get_node("STATUS").player.have_rifle = true
		Shop.get_node("STATUS").player.change_weapon()
		Shop.get_node("STATUS").player.change_weapon()
		if flag_:
			Shop.get_node("STATUS").player.have_rifle = false
		
		
		Shop.check_obj(9)
	elif prd_name == "Fast hands":
		Shop.get_node("STATUS").player.to_set_trap = 65
		Shop.check_obj(10)
		


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.stop()
