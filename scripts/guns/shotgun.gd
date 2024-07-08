class_name Shotgun
extends Gun

@export_range(1, 50) var pellet_count = 5:
	set(value): 
		pellet_count = value
		calculate_spread()
@export_range(0, 90) var spread = 60:
	set(value): 
		spread = value
		calculate_spread()
@export var neat_spread = true

var offset: float
var bullet_dist: float

func _ready() -> void:
	calculate_spread()

func shoot():
	if neat_spread:
		for pellet in pellet_count:
			var bullet_offset = offset - pellet
			bullet_offset *= bullet_dist
			
			var new_bullet: Bullet = spawner.spawn(bullet)
			print(offset)
			
			new_bullet.rotation = deg_to_rad(bullet_offset) + rotation
			add_child(new_bullet)

func calculate_spread():
	offset = (pellet_count - 1) / 2.0	
	bullet_dist = float(spread) / (pellet_count - 1)
	print(bullet_dist)	
