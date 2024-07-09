class_name Avatar
extends Sprite2D

@onready var face: Sprite2D = $Face
@onready var foot_left: Sprite2D = %FootLeft
@onready var foot_right: Sprite2D = %FootRight

var player: Player:
	get:
		return get_parent()

var move_dir: Vector2

@onready var feet = [foot_left, foot_right]
var moving_foot = [false, false]
var foot_pin = [Vector2.ZERO, Vector2.ZERO]

var look_dir: Vector2

func _process(_delta: float) -> void:	
	face.position = look_dir / 200
	
	for i in feet.size():
		if !move_dir.is_zero_approx(): 
			print(feet[i])
			feet[i].global_position = foot_pin[i]
			if feet[i].position.length() > 20:
				foot_pin[i] = global_position + (move_dir * 40)
		else:
			feet[i].position = Vector2.ZERO
			foot_pin[i] = global_position

#func move_foot(new_pos: Vector2):
	#moving_foot = true
	#var foot_tween = get_tree().create_tween()
	#
	#foot_tween.tween_property(left_foot, "position", \
			#new_pos, 0.2)\
			#.set_ease(Tween.EASE_IN_OUT)\
			#.set_trans(Tween.TRANS_CIRC)
	#await foot_tween.finished
	#moving_foot = false
