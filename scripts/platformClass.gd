extends Node

class_name platformCreator
var parent: Object

func _init(parent: Object):
	self.parent = parent

func _ready():
	pass

func _process(delta):
	pass
	
func createPlatform(platformName: String, x, y): 
	var scene = preload("res://scenes/plataform.tscn")
	var obj = scene.instantiate()
	
	obj.name = platformName + str(x)
	obj.position = Vector2(x, y)

	parent.add_child(obj)
	return obj
	
func deletePlatform(platform: Object): # Delete a specific platform.
	platform.queue_free()
