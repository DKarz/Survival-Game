extends StaticBody2D

onready var pick_up_area1 = $CollisionShape2D1
onready var pick_up_area2 = $CollisionShape2D2

func _physics_process(delta):
	
	if pick_up_area1.is_colliding():
		var coll = pick_up_area1.get_collider()
		restore(coll)
	elif pick_up_area2.is_colliding():
		var coll = pick_up_area2.get_collider()
		restore(coll)
			
func restore(coll):
	if coll.name == "Player":
			if coll.health != coll.MAX_HEALTH:
				coll.be_damaged(-50)
				var label = load("res://World/InfoLabel.tscn").instance()
				get_tree().current_scene.add_child(label)
				label.global_position = global_position + Vector2(25,0)
				label.get_node("RichTextLabel").text = "+ 50 to health"
				
				var sound = load("res://PickUpSound.tscn").instance()
				get_tree().current_scene.add_child(sound)
				queue_free()
