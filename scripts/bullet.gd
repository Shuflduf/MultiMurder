extends CharacterBody2D

@onready var move_component: MoveComponent = $MoveComponent

func _ready() -> void:
	move_component.direction = Vector2(
		cos(rotation),
		sin(rotation)
	)
	print(move_component.direction)
