extends Node2D

@onready var spawner_c: SpawnerComponent = $SpawnerComponent

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_at(get_global_mouse_position())
		
	if event.is_action_pressed("mouse_left"):
		spawner_c.spawn()
