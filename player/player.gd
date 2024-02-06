extends CharacterBody2D

var gravityObjects = []

const SPEED = 30.0
const JUMP_VELOCITY = -40.0
var currentGravity = Vector2.ZERO
var nearestAsteroid
var isOnJump = true
var gun

func _ready():
	gun = $gun

func addGravity(gravityObject):
	if !gravityObjects.has(gravityObject):
		gravityObjects.append(gravityObject)
		
func removeGravity(gravityObject):
	if gravityObjects.has(gravityObject):
		gravityObjects.erase(gravityObject)
		
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.pressed:
			var bullet = load("res://player/bullet.tscn").instantiate()
			get_parent().add_child(bullet)
			bullet.global_position = global_position
			bullet.velocity = (event.position - position).normalized()*100

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

	look_at(transform.origin - currentGravity)
	
	gun.look_at(get_viewport().get_mouse_position())
	rotate(PI/2)
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
