extends CharacterBody2D

var speed = 100
var direction = Vector2(1, 0)
var player = null

func _physics_process(delta):
	var motion = direction * speed * delta
	global_position += motion

	# If the player is on the platform, apply the platform's velocity to the player
	if player and is_player_on_platform():
		player.apply_platform_velocity(motion)

	# Reverse direction if necessary (based on RayCast collisions)
	if should_reverse():
		direction *= -1

func is_player_on_platform() -> bool:
	return player and player.is_on_floor()

func _on_CollisionShape2D_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_CollisionShape2D_body_exited(body):
	if body.is_in_group("Player"):
		player = null

func should_reverse() -> bool:
	return $RayCastRight.is_colliding() or $RayCastLeft.is_colliding()
