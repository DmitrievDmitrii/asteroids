extends CharacterBody2D

var gravityObjects = []

const SPEED = 30.0
const JUMP_VELOCITY = -40.0
var currentGravity = Vector2.ZERO

func _physics_process(delta):
	currentGravity = Vector2.ZERO
	for asteroid in gravityObjects:
		currentGravity -= asteroid.getAcceleration(self)

	look_at(transform.origin + currentGravity)
	rotate(PI/2)
	if !is_on_wall():
		velocity += currentGravity * delta
	else:
		velocity = Vector2.ZERO
	print(is_on_wall())
	
	if Input.is_action_just_pressed("jump") and is_on_wall():
		velocity = currentGravity.normalized() * JUMP_VELOCITY
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	print(direction)
	if is_on_wall() and direction:
		currentGravity.normalized().orthogonal()
		velocity += currentGravity.normalized().orthogonal() * direction.x * SPEED
	move_and_slide()
