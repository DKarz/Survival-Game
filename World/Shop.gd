extends CanvasLayer

func _ready():
	set_all_vis(false)

func set_all_vis(do = true):
	for child in get_children():
		if child.name != "STATUS":
			child.visible = do



func unbought():
	for child in get_children():
		if "ObjectShop" in child.name:
			child.unbought()
	
	
func check_obj(ind):
	if ind == 0:
		$ObjectShop.was_bought()
	elif ind == 1:
		$ObjectShop1.was_bought()
	elif ind == 2:
		$ObjectShop7.was_bought()
	elif ind == 3:
		$ObjectShop8.was_bought()
	elif ind == 4:
		$ObjectShop9.was_bought()
	elif ind == 5:
		$ObjectShop10.was_bought()
	elif ind == 6:
		$ObjectShop11.was_bought()
	elif ind == 7:
		$ObjectShop12.was_bought()
	elif ind == 8:
		$ObjectShop13.was_bought()
	elif ind == 9:
		$ObjectShop14.was_bought()
	elif ind == 10:
		$ObjectShop15.was_bought()
	
	
