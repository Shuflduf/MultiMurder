class_name Bullet
extends CharacterBody2D

@onready var move_component: MoveComponent = $MoveComponent

func _ready() -> void:
	update_direction(rotation)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()

func update_direction(new_rot: float):
	rotation = new_rot
	
	move_component.direction = Vector2(
		cos(new_rot),
		sin(new_rot)
	)
