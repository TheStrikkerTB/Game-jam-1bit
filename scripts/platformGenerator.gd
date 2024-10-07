extends Node2D

@onready var game = get_parent()
@onready var timer = Timer.new()

#OBS:instead of playerPosX(temporary) use last platformPosX, this is temporary.

var y = -140 # Height which will be spawned
var gap = 80 # Jump gap
var playerPosX

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.wait_time = 2
	timer.start()

	timer.connect("timeout", Callable(self, "generatePlatforms"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	playerPosX = int(game.get_node("Player").position.x - 1)

func generatePlatforms(): # Generate platforms relative to the player position.
	var x
	
	if playerPosX >= 120:
		x = playerPosX - gap
		createPlatform(x,y)	
		return
	elif playerPosX <= -120:
		x = playerPosX + gap
		createPlatform(x,y)	
		return

	var plusOrMinus = gap if randi() % 2 == 0 else -gap
	print(plusOrMinus)
	x = playerPosX +(plusOrMinus)
	createPlatform(x,y)	
		
		
func createPlatform(x,y): 
	var scene = preload("res://scenes/plataform.tscn")
	var obj = scene.instantiate()	

	obj.position = Vector2(x, y)
	game.add_child(obj)
	return obj
