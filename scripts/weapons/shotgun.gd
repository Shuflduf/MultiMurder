class_name Shotgun
extends Gun

@export_range(1, 50) var pellet_count = 5:
	set(value): 
		pellet_count = value
		calculate_spread()
@export_range(0, 180) var spread = 60:
	set(value): 
		spread = value
		calculate_spread()
@export var neat_spread = true

var offset: float
var bullet_dist: float
var half_spread: float

func _ready() -> void:
	super()
	calculate_spread()

func shoot():
	for pellet in pellet_count:
		var bullet_offset: float
		
		if neat_spread:
			bullet_offset = offset - pellet
			bullet_offset *= bullet_dist
				
		else:
			bullet_offset = randf_range(-half_spread, half_spread)
				
		var bullet_transform: Transform2D
		bullet_transform = bullet_transform.rotated(deg_to_rad(bullet_offset) + rotation)
		bullet_transform = bullet_transform.translated(hand.global_position)
		spawn_bullet(bullet, bullet_transform)
	ammo -= 1
		
func calculate_spread():
	offset = (pellet_count - 1) / 2.0	
	bullet_dist = float(spread) / (pellet_count - 1)
	half_spread = spread / 2.0
