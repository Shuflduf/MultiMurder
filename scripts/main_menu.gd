extends Control

@export_file("*.tscn") var next_scene: String

func _on_join_pressed() -> void:
	get_parent().move_child(self, get_parent().get_child_count() - 1)
	SceneManager.transition_to(next_scene)
