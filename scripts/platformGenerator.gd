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
	timer.connect("timeout", Callable(self, "deleteNodesBelowViewPort")) 

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

		
func createPlatform(x,y): 
	var scene = preload("res://scenes/plataform.tscn")
	var obj = scene.instantiate()
	
	obj.name = "Platform_X " + str(x)
	obj.position = Vector2(x, y)
	lastPlatform = obj	

	game.add_child(obj)
	return obj
	
func deletePlatform(platform): # Delete a specific platform.
	platform.queue_free()
	
func deleteNodesBelowViewPort(): # Delete nodes if outside the room ex: y > 0
	for child in game.get_children():
		if child.position.y > get_viewport_rect().size.y - 400:
			child.queue_free()       #- 400 is arbitrary, decrease viewportSize.
			#print("deleted: ", child.name)
