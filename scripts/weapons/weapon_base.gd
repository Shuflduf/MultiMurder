class_name Weapon
extends Node2D

@export var flip_enabled = true
@export var automatic = false
@export_range(0.01, 2) var fire_speed = 0.2

@onready var sprite: Sprite2D = $Hand/Sprite2D
@onready var hand: Node2D = $Hand

signal fired

var player: Player :
	get:
		return get_parent().get_parent()

func look_at_mouse():
	look_at(get_global_mouse_position())
	if flip_enabled:
		if cos(rotation) > 0:
			sprite.flip_v = false
		else:
			sprite.flip_v = true

func _process(_delta: float) -> void:
	if !player.synchronizer.is_multiplayer_authority():
		return
	else:
		if not automatic:
			if Input.is_action_just_pressed("mouse_left"):
				fire()
		else:
			if Input.is_action_pressed("mouse_left"):
				fire()

func fire():
	pass
