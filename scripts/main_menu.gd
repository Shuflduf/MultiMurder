extends Control

@export_file("*.tscn") var next_scene: String
@onready var port_box: SpinBox = $VBoxContainer/HBoxContainer/Port

func _on_join_pressed() -> void:
	get_parent().move_child(self, get_parent().get_child_count() - 1)
	Global.current_type = Global.gameType.Join
	Global.port = port_box.value
	SceneManager.transition_to(next_scene)


func _on_host_pressed() -> void:
	get_parent().move_child(self, get_parent().get_child_count() - 1)
	Global.current_type = Global.gameType.Host
	Global.port = port_box.value
	SceneManager.transition_to(next_scene)
