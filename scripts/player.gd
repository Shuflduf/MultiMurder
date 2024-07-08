extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D

func _process(delta: float) -> void:
	var camera_pos = get_local_mouse_position()
	print(camera_pos)
	camera.position = camera_pos / 3
