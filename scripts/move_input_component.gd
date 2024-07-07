class_name MoveInputComponent

extends Node

@export var movement_component : MoveComponent
@export var top_down := false

func _physics_process(_delta):
	if !top_down:
		var input_axis = Input.get_axis("left","right")
		movement_component.direction.x = input_axis
	elif top_down:
		var input_dir = Input.get_vector("left","right","up","down")
		movement_component.direction = input_dir
