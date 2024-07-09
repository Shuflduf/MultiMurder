class_name Avatar
extends Sprite2D

@onready var left_foot: Sprite2D = $FootLeft

var move_dir: Vector2

var left_foot_position: Vector2

func _process(_delta: float) -> void:
	if !move_dir.is_zero_approx(): 
		left_foot.global_position = left_foot_position
		if (left_foot.global_position - global_position).length() > 100:
			left_foot_position = global_position + (move_dir * 50)
			
	else:
		left_foot.position = Vector2.ZERO

