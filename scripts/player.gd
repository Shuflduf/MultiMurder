extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D

func _process(_delta: float) -> void:
	camera.position = get_local_mouse_position() / 3
