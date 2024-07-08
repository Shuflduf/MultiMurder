class_name Bullet
extends CharacterBody2D

@onready var move_component: MoveComponent = $MoveComponent
@export var timespan = 10

func _ready() -> void:
	update_direction(rotation)
	await get_tree().create_timer(timespan).timeout
	queue_free()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()

func update_direction(new_rot: float):
	rotation = new_rot
	
	move_component.direction = Vector2(
		cos(new_rot),
		sin(new_rot)
	)

func _process(_delta: float) -> void:
	move_component.move()
