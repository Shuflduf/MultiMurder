class_name Gun
extends Weapon

@export var bullet: PackedScene

@export var clip = 6
@export var reserve = 20

@export_range(0, 90) var recoil = 10
@export_range(0, 10) var reload_speed = 0.5

#@onready var barrel: Node2D = $barrel
#@onready var sprite: Sprite2D = $barrel/Sprite2D
@onready var bullet_point: Marker2D = %BulletPoint
@onready var reload_indicator: TextureProgressBar = %ReloadIndicator

var player: Player :
	get:
		return get_parent().get_parent()

var shoot_cooldown = fire_speed
var ammo: int:
	set(value):
		ammo = value
		fired.emit()
		
		if value != clip:
			recoil_gun()
			
		if value == 0:
			reload()

var recoil_offset: float
var reloading = false

var reload_ind_offset: float

func reload():
	reloading = true
	var tween = get_tree().create_tween()
	tween.tween_property(reload_indicator, "value", 100, reload_speed)
	await tween.finished
	reloading = false
	reload_indicator.value = 0
	reserve -= clip - ammo
	ammo = clip
	
func look_at_mouse():
	look_at(get_global_mouse_position())
	if cos(rotation) > 0:
		sprite.flip_v = false
		reload_indicator.position.y = reload_ind_offset - reload_indicator.size.y / 2
	else:
		sprite.flip_v = true
		reload_indicator.position.y = -reload_ind_offset - reload_indicator.size.y / 2
	rotation_degrees += recoil_offset



func _ready() -> void:	
	ammo = clip
	reload_ind_offset = reload_indicator.position.y

func shoot():
	if !ammo <= 0:
		spawn_bullet(bullet, hand.global_transform)
		ammo -= 1
	
func recoil_gun():
	var back_tween = get_tree().create_tween()
	var offset = -1
	if sprite.flip_v:
		offset *= -1
	
	back_tween.tween_property(self, "recoil_offset", rotation + deg_to_rad(recoil * 100 * offset), fire_speed / 3)\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_QUART)
	await back_tween.finished
	var forward_tween = get_tree().create_tween()
	forward_tween.tween_property(self, "recoil_offset", 0, (fire_speed / 3) * 2)\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_QUART)


func spawn_bullet(new_bullet: PackedScene, bullet_transform: Transform2D):
	var offset = bullet_point.position
	if sprite.flip_v:
		offset *= Vector2.UP
	
	var main_scene = get_tree().root.find_child("Main", true, false)
	main_scene.rpc("add_bullet", new_bullet.get_path(), \
			bullet_transform.translated_local(offset), player)


func _process(delta: float) -> void:
	if !player.synchronizer.is_multiplayer_authority():
		return
	if shoot_cooldown >= 0:
		shoot_cooldown -= delta
	else:
		if not automatic:
			if Input.is_action_just_pressed("mouse_left"):
				shoot()
				shoot_cooldown = fire_speed
		else:
			if Input.is_action_pressed("mouse_left"):
				shoot()
				shoot_cooldown = fire_speed
		
