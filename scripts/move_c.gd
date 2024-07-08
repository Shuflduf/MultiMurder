class_name MoveComponent
extends Node

@export var direction : Vector2
@export var actor : CharacterBody2D
@export var speed : int
@export var top_down := false

func _process(_delta):
	if !top_down:
		actor.velocity.x = direction.x * speed
		actor.velocity.y = direction.y
	elif top_down:
		actor.velocity = direction * speed

	actor.move_and_slide()
