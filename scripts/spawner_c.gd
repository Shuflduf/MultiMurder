class_name SpawnerComponent
extends Node2D

func spawn(scene: PackedScene) -> Node:
	var instance = scene.instantiate()
	instance.global_transform = global_transform
	
	return instance
	
	
	
	#return instance
