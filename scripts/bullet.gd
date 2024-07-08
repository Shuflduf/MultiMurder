extends CharacterBody2D

@onready var move_component: MoveComponent = $MoveComponent

func _ready() -> void:
	move_component.direction = Vector2(
		cos(rotation),
		sin(rotation)
	)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()
