class_name Avatar
extends Sprite2D

@onready var left_foot: Sprite2D = $FootLeft
@onready var body: Sprite2D = $"."

var moving = false

var left_foot_position: Vector2

func _process(delta: float) -> void:
	if moving: 
		left_foot.global_position = left_foot_position
		if (left_foot.global_position - body.global_position).length() > 100:
			left_foot_position = body.global_position
	else:
		left_foot.position = Vector2.ZERO

