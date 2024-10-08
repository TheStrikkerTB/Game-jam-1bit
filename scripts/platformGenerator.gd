extends Node2D


var platformClass = preload("res://scripts/platformClass.gd")
var platformInstance

@onready var game = get_parent()
@onready var timer = Timer.new()

var y = -140 # Height which will be spawned,
var GAP = 80 # Jump gap.

var playerPosX # X Posistion of player.
var lastPlatform # Last platform created.
var isFirstPlatformCreated = false # Flag for the first platform.
 
func _ready():
	platformInstance = platformClass.new(game)
	
	add_child(timer)
	timer.wait_time = 0.5
	timer.start()

	timer.connect("timeout", Callable(self, "generatePlatforms"))
	timer.connect("timeout", Callable(self, "deleteNodesBelowViewPort")) 
	

func _process(_delta):
	playerPosX = int(game.get_node("Player").position.x - 1)

func generatePlatforms(): # Generate platforms relative to platfrom/player position.
	var x
	var plusOrMinus = GAP if randi() % 2 == 0 else -GAP
	
	if isFirstPlatformCreated == false:
		isFirstPlatformCreated = true
		x = playerPosX +(plusOrMinus)

		var firstPlatform = platformInstance.createPlatform("FirstPlatform", x, y)
		lastPlatform = firstPlatform
		return	
		
	if lastPlatform.position.x >= 110:
		x = lastPlatform.position.x - GAP
	elif lastPlatform.position.x <= -110:
		x = lastPlatform.position.x + GAP
	else:
		x = lastPlatform.position.x + (plusOrMinus)	

	var newPlatform = platformInstance.createPlatform("Platform", x, y)	
	lastPlatform = newPlatform
	
func deleteNodesBelowViewPort(): # Delete nodes if outside the room ex: y > 0
	for child in game.get_children():
		if child.position.y > get_viewport_rect().size.y - 400:
			child.queue_free()       #- 400 is arbitrary, decrease viewportSize.
			#print("deleted: ", child.name)
