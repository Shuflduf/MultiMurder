class_name Gun
extends Node2D

@export var bullet: PackedScene
@export_range(0.01, 2) var fire_speed = 0.2
@export var clip = 6
@export var reserve = 20

@export var automatic = false

@onready var barrel: Node2D = $barrel
@onready var spawner: SpawnerComponent = $barrel/SpawnerComponent

var shoot_cooldown = fire_speed

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_at(get_global_mouse_position())
		
	if event.is_action_pressed("mouse_left"):
		shoot()

func shoot():
	if shoot_cooldown <= 0:
		add_child(spawner.spawn(bullet))
		shoot_cooldown = fire_speed

func _process(delta: float) -> void:
	if shoot_cooldown >= 0:
		shoot_cooldown -= delta
	
	if automatic and Input.is_action_pressed("mouse_left"):
		shoot()
