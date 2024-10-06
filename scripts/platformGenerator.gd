extends Node2D

@onready var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.wait_time = 2.0
	timer.start()

	timer.connect("timeout", Callable(self, "generatePlatforms"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func generatePlatforms():
	var x = randi() % 160 - 80
	var y = -140

	createPlatform(x,y)

func createPlatform(x,y): 
	var game = get_parent()
	var scene = preload("res://scenes/plataform.tscn")
	var obj = scene.instantiate()	

	obj.position = Vector2(x, y)
	game.add_child(obj)
	return obj
