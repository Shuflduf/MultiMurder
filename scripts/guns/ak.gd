class_name AK
extends Gun

@export_range(0, 180) var spread = 20:
	set(value):
		half_spread = value / 2.0
		spread = value
	
var half_spread = spread / 2.0

func shoot():
	var new_bullet: Bullet = spawner.spawn(bullet)
	var bullet_offset = randf_range(-half_spread, half_spread)
	var bullet_transform: Transform2D
	bullet_transform = bullet_transform.rotated(deg_to_rad(bullet_offset) + rotation)
	bullet_transform = bullet_transform.translated(barrel.global_position)
	spawn_bullet(bullet, bullet_transform)
	ammo -= 1
	
