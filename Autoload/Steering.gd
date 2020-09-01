extends Node

const DEFAULT_MASS = 2.0
const DEFAULT_MAX_SPEED = 400.0



static func follow(
	velocity: Vector2,
	global_position: Vector2,
	target_position: Vector2,
	max_speed = DEFAULT_MAX_SPEED,
	mass = DEFAULT_MASS
	) -> Vector2:
		
	var desired_velocity = (target_position - global_position).normalized() *max_speed
	var steering = (desired_velocity - velocity) / mass
	
	
	
	return velocity + steering
