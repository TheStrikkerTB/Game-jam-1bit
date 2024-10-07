extends Node

@onready var platformSpeed = 200
@onready var direction = Vector2(0,1)
@onready var platform = self


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var motion = direction * platformSpeed * delta
	platform.position += motion
	
