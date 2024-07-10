class_name Melee
extends Weapon


func _unhandled_input(event: InputEvent) -> void:
	if !visible:
		return
	if event.is_action_pressed("mouse_left"):
		punch()

func punch():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(hand, "position:x", hand.position.x + 30, 0.5)
