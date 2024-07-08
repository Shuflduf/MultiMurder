class_name Gun
extends Node2D

@export var bullet: PackedScene
@export_range(0.01, 2) var fire_speed = 0.2
@export var clip = 6
@export var reserve = 20
@export var automatic = false

@onready var barrel: Node2D = $barrel
@onready var spawner: SpawnerComponent = $barrel/SpawnerComponent

var synchronizer: MultiplayerSynchronizer

var shoot_cooldown = fire_speed
var ammo: int:
	set(value):
		ammo = value
		fired.emit()

signal fired

func look_at_mouse():
	look_at(get_global_mouse_position())

func _ready() -> void:	
	ammo = clip

#func _unhandled_input(event: InputEvent) -> void:
	##if !synchronizer.is_multiplayer_authority():
		##return
	#if event is InputEventMouseMotion:
		#look_at(get_global_mouse_position())

func shoot():
	spawn_bullet(spawner.spawn(bullet))
	ammo -= 1
	
func spawn_bullet(new_bullet: Node):
	get_tree().root.add_child(new_bullet)


func _process(delta: float) -> void:
	#if !synchronizer.is_multiplayer_authority():
		#return
	if shoot_cooldown >= 0:
		shoot_cooldown -= delta
	else:
		if not automatic:
			if Input.is_action_just_pressed("mouse_left"):
				shoot()
				shoot_cooldown = fire_speed
		else:
			if Input.is_action_pressed("mouse_left"):
				shoot()
				shoot_cooldown = fire_speed
		
