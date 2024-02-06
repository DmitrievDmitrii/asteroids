extends Node2D
var asteroid
var asteroid2
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	asteroid = $asteroid
	asteroid2 = $asteroid2
	player = $player
	#player.gravityObjects.append(asteroid)
	#player.gravityObjects.append(asteroid2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
