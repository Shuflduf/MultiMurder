class_name Weapon
extends Node2D

signal fired
@onready var sprite: Sprite2D = $Hand/Sprite2D
@onready var hand: Node2D = $Hand

func look_at_mouse():
	look_at(get_global_mouse_position())
	if cos(rotation) > 0:
		sprite.flip_v = false
		#reload_indicator.position.y = reload_ind_offset - reload_indicator.size.y / 2
	else:
		sprite.flip_v = true
		#reload_indicator.position.y = -reload_ind_offset - reload_indicator.size.y / 2
	#rotation_degrees += recoil_offset
