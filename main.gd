extends Node2D
var asteroid
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	asteroid = $asteroid
	player = $player
	player.gravityObjects.append(asteroid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
