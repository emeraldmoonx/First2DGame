extends CharacterBody2D

@export var speed: float = 50.0  # Speed of the platform
var move_direction: Vector2 = Vector2.RIGHT  # Initial movement direction

func _ready():
	# Ensure both RayCasts are enabled
	$RayCastRight.enabled = true
	$RayCastLeft.enabled = true

func _physics_process(_delta):
	# Set the velocity based on the current movement direction and speed
	velocity = move_direction * speed

	# Apply the movement using move_and_slide()
	move_and_slide()

	# Check for collisions using RayCasts and reverse direction if necessary
	if move_direction == Vector2.RIGHT and $RayCastRight.is_colliding():
		reverse_direction()
	elif move_direction == Vector2.LEFT and $RayCastLeft.is_colliding():
		reverse_direction()

func reverse_direction():
	# Reverse the movement direction
	move_direction = -move_direction
