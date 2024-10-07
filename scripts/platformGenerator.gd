extends Node2D

@onready var game = get_parent()
@onready var timer = Timer.new()


var y = -140 # Height which will be spawned
var gap = 80 # Jump gap
var playerPosX
var lastPlatform 
var isFirstPlatformCreated = false # Flag for the first platform
 
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.wait_time = 0.5
	timer.start()

	timer.connect("timeout", Callable(self, "generatePlatforms"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	playerPosX = int(game.get_node("Player").position.x - 1)

func generatePlatforms(): # Generate platforms relative to platfrom/player position.
	var x
	var plusOrMinus = gap if randi() % 2 == 0 else -gap
	
	if isFirstPlatformCreated == false:
		isFirstPlatformCreated = true
		x = playerPosX +(plusOrMinus)
		createPlatform(x,y)
		return	
	if lastPlatform.position.x >= 110:
		x = lastPlatform.position.x - gap
		createPlatform(x,y)	
		return
	elif lastPlatform.position.x <= -110:
		x = lastPlatform.position.x + gap
		createPlatform(x,y)	
		return

	#print(plusOrMinus)
	x = lastPlatform.position.x +(plusOrMinus)
	createPlatform(x,y)
	print(x)	
		
		
func createPlatform(x,y): 
	var scene = preload("res://scenes/plataform.tscn")
	var obj = scene.instantiate()
	lastPlatform = obj	

	obj.position = Vector2(x, y)
	game.add_child(obj)
	return obj
	
func deletePlatform(platform):
	pass	
