class_name ShootComponent
extends Node

@export var spawn_component : SpawnerComponent
@export var actor : CharacterBody2D

@export var bullet: PackedScene

func _input(event):
	if event.is_action_pressed("mouse_left"):
		spawn_component.scene = bullet
		spawn_component.spawn()
