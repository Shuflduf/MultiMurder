extends Control

@onready var ammo_label: Label = $VBoxContainer/Ammo
@onready var reserve_label: Label = $VBoxContainer/Reserve

var ammo: int
var clip: int
var reserve: int

func update_all():
	ammo_label.text = "Ammo: " + str(ammo) + "/" + str(clip)
	reserve_label.text = "Reserve: " + str(reserve)
