extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var weapon_parent: Node2D = $Weapon
@onready var hud: Control = $CanvasLayer/HUD

@export var weapons: Array[PackedScene]

var set_new_weapon: PackedScene:
	set(value):
		if set_new_weapon != null:
			if value.resource_path == set_new_weapon.resource_path:
				return
		if weapon_parent.get_child_count() > 0:
			weapon_parent.get_child(0).queue_free()	
				
		set_new_weapon = value
		weapon_parent.add_child(value.instantiate())
		current_weapon = weapon_parent.get_child(0)

var current_weapon: Gun:
	set(value):
		value.fired.connect(func(): update_hud())
		current_weapon = value
		update_hud()
	get:
		return weapon_parent.get_child(0)

func _process(_delta: float) -> void:
	camera.position = get_local_mouse_position() / 3


func _ready() -> void:
	set_new_weapon = weapons[0]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("switch_1"):
		set_new_weapon = weapons[0]
	elif event.is_action_pressed("switch_2"):
		set_new_weapon = weapons[1]
		
func update_hud():
	print(current_weapon)
	hud.ammo = current_weapon.ammo
	hud.clip = current_weapon.clip
	hud.reserve = current_weapon.reserve
	hud.update_all()
