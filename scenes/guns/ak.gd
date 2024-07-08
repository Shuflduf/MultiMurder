class_name AK
extends Gun

@export_range(0, 180) var spread = 20:
	set(value):
		half_spread = value / 2
		spread = value
	
var half_spread = spread / 2

func shoot():
	var new_bullet: Bullet = spawner.spawn(bullet)
	var bullet_offset = randf_range(-half_spread, half_spread)
	new_bullet.rotation = deg_to_rad(bullet_offset) + rotation
	add_child(new_bullet)
	
