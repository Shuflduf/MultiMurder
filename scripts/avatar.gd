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

var foot_pin = [Vector2.ZERO, Vector2.ZERO]

@export var look_dir: Vector2:
	set(value):
		if face == null:
			await ready
		look_dir = value
		face.position = value / 200

var just_started_moving = false
var last_dir: Vector2

func _process(_delta: float) -> void:	
	#face.position = look_dir / 200

	for i in feet.size():
		
		feet[i].global_position = foot_pin[i] # update foot pos
		
		if !move_dir.is_zero_approx(): 
			
			if !just_started_moving or last_dir != move_dir:
				step_first()
				
			just_started_moving = true
			last_dir = move_dir
		
				
			
			if feet[i].position.length() > 20:
				foot_pin[i] = global_position + (move_dir * step_dist) # replace with move()
					
					#move_foot(i, global_position + (move_dir * step_dist))
		else:
			just_started_moving = false
			#if !moving_foot[i]:
			feet[i].position = Vector2.ZERO
			foot_pin[i] = global_position
				#move_foot(i, global_position)

#func move_foot(foot: int, new_pos: Vector2):
	#moving_foot[foot] = true
	#var foot_tween = get_tree().create_tween()\
			#.set_ease(Tween.EASE_IN_OUT)\
			#.set_trans(Tween.TRANS_CIRC)
	#
	#var new_array = foot_pin
	#new_array[foot] = new_pos
	#foot_tween.tween_property(self, "foot_pin", new_array, 0.2)
			#
			#
	#await foot_tween.finished
	#moving_foot[foot] = false

func step_first():
	#move_foot(stepping_foot, global_position + (move_dir * step_dist)) 
	foot_pin[stepping_foot] += move_dir * step_dist
