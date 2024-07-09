class_name Avatar
extends Sprite2D

@onready var left_foot: Sprite2D = $FootLeft

var move_dir: Vector2
var moving_foot = false

var left_foot_position: Vector2

func _process(_delta: float) -> void:
	print(left_foot_position)
	left_foot.global_position = left_foot_position
	if !move_dir.is_zero_approx() and !moving_foot: 
		if (left_foot.global_position - global_position).length() > 100:
			move_foot()
			
	#else:
		#left_foot.position = Vector2.ZERO

func move_foot():
	moving_foot = true
	var foot_tween = get_tree().create_tween()
	foot_tween.tween_property(self, "left_foot_position", \
			global_position + (move_dir * 50), 0.4)\
			.set_ease(Tween.EASE_IN_OUT)\
			.set_trans(Tween.TRANS_CIRC)
	await foot_tween.finished
	moving_foot = false
