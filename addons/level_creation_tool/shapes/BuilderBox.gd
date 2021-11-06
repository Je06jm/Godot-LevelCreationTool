tool
extends BuilderBasic
class_name BuilderBox

func get_mesh_type():
	return TYPE_BOX

func get_mesh():
	return preload("res://addons/level_creation_tool/shapes/cube.mesh")
