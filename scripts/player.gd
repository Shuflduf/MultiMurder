extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var weapon_parent: Node2D = $Weapon

@export var weapons: Array[PackedScene]

var active_weapon: PackedScene:
	set(value):
		if active_weapon != null:
			if value.resource_path == active_weapon.resource_path:
				return
		if weapon_parent.get_child_count() > 0:
			weapon_parent.get_child(0).queue_free()	
				
		active_weapon = value
		weapon_parent.add_child(value.instantiate())
		#weapon_parent.add_child(value)
	
func _process(_delta: float) -> void:
	camera.position = get_local_mouse_position() / 3


func _ready() -> void:
	active_weapon = weapons[0]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("switch_1"):
		active_weapon = weapons[0]
	elif event.is_action_pressed("switch_2"):
		active_weapon = weapons[1]
		
		
	
