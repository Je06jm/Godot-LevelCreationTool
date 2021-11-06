tool
extends BuilderBasic
class_name BuilderCylinder

func get_mesh_type():
	return TYPE_CYLINDER

func get_mesh():
	return preload("res://addons/level_creation_tool/shapes/cylinder.mesh")
