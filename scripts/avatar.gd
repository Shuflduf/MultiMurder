class_name Avatar
extends Sprite2D

@onready var left_foot: Sprite2D = $FootLeft
@onready var foot_right: Sprite2D = $FootRight
var feet = [left_foot, foot_right]

@onready var face: Sprite2D = $Face

var player: Player:
	get:
		return get_parent()

var move_dir: Vector2
var moving_foot = [false, false]

var foot_pin = [Vector2.ZERO, Vector2.ZERO]

var look_dir: Vector2

func _process(_delta: float) -> void:	
	face.position = look_dir / 200
	if !move_dir.is_zero_approx(): 
		for index in feet.size:
			feet[index].global_position = foot_pin[index]
		left_foot.global_position = left_foot_position
		#left_foot.position = -global_position / 4
		if left_foot.position.length() > 20:
			#var new_dir = (left_foot.position - player.global_position)
			#print(new_dir)
			left_foot_position = global_position + (move_dir * 40)
			#left_foot_position = global_position + (move_dir * 150)
			#move_foot(left_foot_position)
			#
	else:
		left_foot.position = Vector2.ZERO
		left_foot_position = global_position

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
