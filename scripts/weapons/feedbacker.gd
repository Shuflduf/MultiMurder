extends Melee


func deal_damage():
	if hitbox.get_overlapping_bodies() != []:
		for body in hitbox.get_overlapping_bodies():
			
			if body is Player:
				if body == player:
					continue 
				main_scene.rpc("hurt_player", body.name, damage)
				return
				
			if body is Bullet:
				print("AHH")
				if body.bullet_owner == player:
					continue
				body.bullet_owner = player
				#print(get_local_mouse_position())
				body.look_at(body.get_local_mouse_position())
				body.update_direction(body.rotation)
