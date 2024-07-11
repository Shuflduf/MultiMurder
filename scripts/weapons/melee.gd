class_name Melee
extends Weapon

@onready var hitbox: Area2D = $Hand/HitBox

@export var damage = 15
@export_range(0, 100) var punch_dist = 30

var rest_pos: float
var punching = false

func fire():
	if punching:
		return
	var tween = get_tree().create_tween()
	punching = true
	tween.tween_property(hand, "position:x", rest_pos + punch_dist, fire_speed / 2)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(hand, "position:x", rest_pos, fire_speed)\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	await get_tree().create_timer(fire_speed / 2).timeout
	if hitbox.get_overlapping_bodies() != []:
		for body in hitbox.get_overlapping_bodies():
			if body is Player:
				if body == player:
					continue 
				body.health -= damage
				body.update_hud()
	
	punching = false
	
func _ready() -> void:
	rest_pos = hand.position.x

#func _on_hit_box_body_entered(body: Node2D) -> void:
	#if !punching:
		#return
	#if body is Player:
		#if body == player:
			#return
		#body.health -= damage
		
