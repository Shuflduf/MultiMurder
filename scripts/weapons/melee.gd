class_name Melee
extends Weapon


@export_range(0, 100) var punch_dist = 30

var rest_pos: float
var punching = false

func _unhandled_input(event: InputEvent) -> void:
	if !visible:
		return
	if event.is_action_pressed("mouse_left"):
		punch()

func punch():
	if punching:
		return
	var tween = get_tree().create_tween()
	punching = true
	tween.tween_property(hand, "position:x", rest_pos + punch_dist, fire_speed / 2)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(hand, "position:x", rest_pos, fire_speed)\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	await tween.finished
	punching = false
	
func _ready() -> void:
	rest_pos = hand.position.x
