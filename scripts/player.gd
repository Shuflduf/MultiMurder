class_name Player
extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var weapon_parent: Node2D = $Weapon
@onready var hud: Control = $CanvasLayer/HUD
@onready var name_label: Label = $Name
@onready var move_c: MoveComponent = $MoveComponent
@onready var health_bar: ProgressBar = $HealthBar
@onready var avatar: Avatar = $Avatar

# Synchronized Values
@export var username = Global.username:
	set(value):
		username = value
		if name_label == null:
			await get_tree().physics_frame
		name_label.text = value
@export var weapon_rot: float:
	set(value):
		if weapon_parent == null:
			await get_tree().process_frame
		current_weapon.rotation = value
	get:
		return current_weapon.rotation
@export var weapon_index = 0:
	set(value):
		weapon_index = value
		if weapon_parent == null:
			await get_tree().process_frame
		for gun in weapon_parent.get_children():
			gun.hide()
			gun.set_process(false)
		weapon_parent.get_child(value).show()
		weapon_parent.get_child(value).set_process(true)
		update_hud()
@export var weapon_upsidedown: bool:
	
	set(value):
		if weapon_parent == null:
			await get_tree().process_frame
		current_weapon.sprite.flip_v = value
	get:
		return current_weapon.sprite.flip_v
@export var health: = 100:
	set(value):
		health = value
		health_bar.value = value

@export var synchronizer: MultiplayerSynchronizer
@export var weapons: Array[PackedScene]

var current_weapon: Gun:
	get: 
		return weapon_parent.get_child(weapon_index)

func _process(_delta: float) -> void:
	camera.position = get_local_mouse_position() / 3
	if !synchronizer.is_multiplayer_authority():
		return
	var input_dir = Input.get_vector("left","right","up","down")
	avatar.move_dir = velocity.normalized()
	avatar.look_dir = get_local_mouse_position()
	move_c.direction = input_dir
	move_c.move()
	current_weapon.look_at_mouse()

func _enter_tree() -> void:
	
	synchronizer.set_multiplayer_authority(str(name).to_int())

func _ready() -> void:
	name_label.text = username
	if username.is_empty():
		username = name
		
	if synchronizer.is_multiplayer_authority():
		camera.make_current()
		hud.show()
	
	for gun in weapons:
		weapon_parent.add_child(gun.instantiate())
	for gun in weapon_parent.get_children():
		gun.hide()
		gun.fired.connect(func(): update_hud())
	weapon_index = 0
		
func _unhandled_input(event: InputEvent) -> void:
	
		
	if event.is_action_pressed("switch_1"):
		weapon_index = 0
	elif event.is_action_pressed("switch_2"):
		weapon_index = 1
		
func update_hud():
	hud.ammo = current_weapon.ammo
	hud.clip = current_weapon.clip
	hud.reserve = current_weapon.reserve
	hud.update_all()
