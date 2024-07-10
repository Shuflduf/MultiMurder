class_name Weapon
extends Node2D

signal fired
@onready var sprite: Sprite2D = $Hand/Sprite2D
@onready var hand: Node2D = $Hand

@export var flip_enabled = true

func look_at_mouse():
	look_at(get_global_mouse_position())
	if flip_enabled:
		if cos(rotation) > 0:
			sprite.flip_v = false
		else:
			sprite.flip_v = true
