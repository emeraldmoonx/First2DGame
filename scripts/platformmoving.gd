extends CharacterBody2D

@export var speed: float = 50.0  # Speed at which the platform moves
@export var move_direction: Vector2 = Vector2.RIGHT  # Direction of movement

func _physics_process(delta):
	# Ensure vertical velocity is zero to prevent downward movement
	velocity = move_direction * speed
	velocity.y = 0
	
	# Apply the velocity to move the platform
	move_and_slide()

	# Reverse direction if the platform hits a wall
	if is_on_wall():
		reverse_direction()

func reverse_direction():
	move_direction = -move_direction  # Reverse the direction vector
