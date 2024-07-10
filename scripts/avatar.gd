class_name Avatar
extends Sprite2D

@onready var face: Sprite2D = $Face
@onready var foot_left: Sprite2D = %FootLeft
@onready var foot_right: Sprite2D = %FootRight
@onready var feet = [foot_left, foot_right]

@export var stepping_foot: Foot
@export_range(0, 100) var step_dist = 80

enum Foot {
	Left,
	Right
}

var player: Player:
	get:
		return get_parent()

var move_dir: Vector2

@export var foot_pin = [Vector2.ZERO, Vector2.ZERO]

@export var look_dir: Vector2:
	set(value):
		if face == null:
			await ready
		look_dir = value
		face.position = value / 200

var just_started_moving = false
var last_dir: Vector2

func _process(_delta: float) -> void:	

	for i in feet.size():
		
		feet[i].global_position = foot_pin[i]
		
		if !move_dir.is_zero_approx(): 
			
			if !just_started_moving or last_dir != move_dir:
				step_first()
				
			just_started_moving = true
			last_dir = move_dir
			
			if feet[i].position.length() > 20:
				foot_pin[i] = global_position + (move_dir * step_dist)
		else:
			just_started_moving = false
			feet[i].position = Vector2.ZERO
			foot_pin[i] = global_position

func step_first():
	foot_pin[stepping_foot] += move_dir * step_dist
