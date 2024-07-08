class_name Shotgun
extends Gun

@export_range(1, 50) var pellet_count = 5
@export_range(0, 90) var spread = 60
@export var neat_spread = true

var offset = pellet_count / 2
var bullet_dist = spread / (pellet_count - 1)

func shoot():
	if neat_spread:
		for pellet in pellet_count:
			var bullet_offset = offset - pellet
			bullet_offset *= bullet_dist
			
			
			print(bullet_offset)
			
			var new_bullet: Bullet = spawner.spawn(bullet)
			
			new_bullet.rotation = deg_to_rad(bullet_offset) + rotation
			add_child(new_bullet)

#func calculate_spread():
	#var offset = pellet_count / 2
	#for i in pellet_count:
		
