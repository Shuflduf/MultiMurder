class_name SpawnerComponent
extends Node2D

@export var scene: PackedScene

func spawn(global_spawn_position: Vector2 = global_position):
	var instance = scene.instantiate()
	instance.global_position = global_spawn_position
	instance.rotation = global_rotation
	add_child(instance)
	
	
	
	#return instance
