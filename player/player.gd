extends CharacterBody2D

var gravityObjects = []

const SPEED = 30.0
const JUMP_VELOCITY = -40.0
var currentGravity = Vector2.ZERO
var nearestAsteroid
var isOnJump = true

func _physics_process(delta):
	currentGravity = Vector2.ZERO
	if is_on_wall():
		isOnJump = false

	for asteroid in gravityObjects:
		currentGravity -= asteroid.getAcceleration(self)
		if nearestAsteroid == null:
			nearestAsteroid = asteroid
		if position.distance_to(asteroid.position) < position.distance_to(nearestAsteroid.position):
			nearestAsteroid = asteroid

	look_at(transform.origin + currentGravity)
	rotate(-PI/2)
	if isOnJump:
		velocity += currentGravity * delta
	else:
		velocity = Vector2.ZERO
	
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")

	if !isOnJump and direction:
		velocity -= nearestAsteroid.getAcceleration(self).normalized().orthogonal() * direction.x * SPEED
		
	if Input.is_action_just_pressed("jump") and !isOnJump:
		isOnJump = true
		velocity -= nearestAsteroid.getAcceleration(self).normalized() * JUMP_VELOCITY
	
	move_and_slide()
