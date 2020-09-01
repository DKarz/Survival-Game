extends StaticBody2D

var stop = false
var time_to_launch = OS.get_ticks_msec()
var first_launch = true

func improve():
	var transform = $Damage/CollisionShape2D.get_shape()
	var oldScale = transform.get_radius()
	transform.set_radius(oldScale + 60)
	
func _physics_process(delta):
	if first_launch:
		if OS.get_ticks_msec() - time_to_launch > 2000:
			first_launch = false
			$Detection/CollisionShape2D.disabled = false
		return
	
	if $Damage/CollisionShape2D.disabled:
		if $Damage.fin:
			queue_free()
	
	if stop:
		return
	
	if $Detection/CollisionShape2D.disabled:
		var crater = load("res://World/Crater.tscn").instance()
		crater.global_position = global_position
		get_tree().current_scene.add_child(crater)
		$Sprite.visible = false
		$Damage.to_blow = true
		$Damage/Light2D.enabled = false
		
		stop = true
		
		




