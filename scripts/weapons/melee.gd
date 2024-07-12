class_name Melee
extends Weapon

@onready var hitbox: Area2D = $Hand/HitBox

@export var damage = 15
@export_range(0, 100) var punch_dist = 30

var rest_pos: float
var punching = false

var main_scene: Node2D

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
	
	deal_damage()
	
	await tween.finished
	punching = false
	
func _ready() -> void:
	rest_pos = hand.position.x
	main_scene = get_tree().root.find_child("Main", true, false)

func deal_damage():
	if hitbox.get_overlapping_bodies() != []:
		for body in hitbox.get_overlapping_bodies():
			if body is Player:
				if body == player:
					continue 
				main_scene.rpc("hurt_player", body.name, damage)
				return
