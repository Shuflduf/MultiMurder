extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var weapon_parent: Node2D = $Weapon
@onready var hud: Control = $CanvasLayer/HUD
@onready var name_label: Label = $Name

@export var synchronizer: MultiplayerSynchronizer
@export var weapons: Array[PackedScene]

var weapon_index = 0:
	set(value):
		weapon_index = value
		for gun in weapon_parent.get_children():
			gun.hide()
			gun.set_process(false)
		weapon_parent.get_child(value).show()
		weapon_parent.get_child(value).set_process(true)
		update_hud()

var current_weapon: Gun:
	get: 
		return weapon_parent.get_child(weapon_index)

func _process(_delta: float) -> void:
	camera.position = get_local_mouse_position() / 3


func _ready() -> void:
	name_label.text = name
	synchronizer.set_multiplayer_authority(str(name).to_int())
	if synchronizer.is_multiplayer_authority():
		camera.make_current()
	
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
