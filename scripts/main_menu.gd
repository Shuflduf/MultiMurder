extends Control

@export_file("*.tscn") var next_scene: String
@onready var port_box: SpinBox = $VBoxContainer/HBoxContainer/Port
@onready var username_box: LineEdit = $VBoxContainer/Username

func _on_join_pressed() -> void:
	Global.current_type = Global.gameType.Join
	Global.address = str(%Address1.value) + "."\
			+ str(%Address2.value) + "."\
			+ str(%Address3.value) + "."\
			+ str(%Address4.value) + "."
			
	transition()
	
func _on_host_pressed() -> void:
	Global.current_type = Global.gameType.Host
	transition()
	

func transition():
	get_parent().move_child(self, get_parent().get_child_count() - 1)
	Global.username = username_box.text
	
	@warning_ignore("narrowing_conversion")
	Global.port = port_box.value
	SceneManager.transition_to(next_scene)
