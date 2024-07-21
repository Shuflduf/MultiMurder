class_name Bullet
extends CharacterBody2D

@onready var move_component: MoveComponent = $MoveComponent
@export var timespan = 10

@export_range(0, 100, 1) var damage = 10

var bullet_owner: Player
var bullet_rotation:
	set(value):
		rotation = value
		update_direction(value)
	get:
		return rotation

func _ready() -> void:
	update_direction(rotation)
	
	await get_tree().create_timer(timespan).timeout
	queue_free()

func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		if !body == bullet_owner:
			body.health -= damage
			queue_free()
	else:
		queue_free()

func update_direction(new_rot: float):
	move_component.direction = Vector2(
		cos(new_rot),
		sin(new_rot)
	)

func _process(_delta: float) -> void:
	move_component.move()
