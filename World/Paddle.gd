extends StaticBody2D

func get_rand(s,e):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = int(rng.randf_range(s,e))
	print(my_random_number)
	return my_random_number

func _ready():
	var s = get_rand(0,5)
	if s == 0:
		$Area2D/Sprite.visible = true
	elif s == 1:
		$Area2D/Sprite2.visible = true
	elif s == 2:
		$Area2D/Sprite3.visible = true
	elif s == 3:
		$Area2D/Sprite4.visible = true
	elif s == 4:
		$Area2D/Sprite5.visible = true
	
