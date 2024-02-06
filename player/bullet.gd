extends CharacterBody2D
var gravityObjects = []
const SPEED = 600.0


func _physics_process(delta):
	var currentGravity = Vector2.ZERO
	for asteroid in gravityObjects:
		currentGravity -= asteroid.getAcceleration(self)

	if is_on_wall():
		queue_free()
	velocity += currentGravity * delta
	move_and_slide()


func addGravity(gravityObject):
	if !gravityObjects.has(gravityObject):
		gravityObjects.append(gravityObject)
		
func removeGravity(gravityObject):
	if gravityObjects.has(gravityObject):
		gravityObjects.erase(gravityObject)
