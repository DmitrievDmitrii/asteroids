extends StaticBody2D
const  G = 1000
var mass = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getAcceleration(object):
	var distance = self.position.distance_to(object.position)
	var direction = self.position.direction_to(object.position).normalized()
	var acceleration = (G * mass) / distance ** 2
	return direction * acceleration


func _on_gravity_area_body_entered(body):
	print("entered2")
	body.addGravity(self)


func _on_gravity_area_body_exited(body):
	print("exited2")
	body.removeGravity(self)
