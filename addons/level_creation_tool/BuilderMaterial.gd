tool
extends ShaderMaterial
class_name BuilderMaterial

export(Texture) var albedo : Texture = null setget _set_albedo, _get_albedo
export(Texture) var metalic : Texture = null setget _set_metalic, _get_metalic
export(Texture) var roughness : Texture = null setget _set_roughness, _get_roughness
export(Texture) var ao : Texture = null setget _set_ao, _get_ao
export(Texture) var emission : Texture = null setget _set_emission, _get_emission
export(Texture) var normalmap : Texture = null setget _set_normalmap, _get_normalmap
export(float) var normalmap_scale := 1.0 setget _set_normalmap_scale, _get_normalmap_scale

func _init():
	shader = preload("res://addons/level_creation_tool/shaders/cube.shader")

func _get_albedo():
	return albedo

func _set_albedo(tex):
	albedo = tex
	set_shader_param("albedo", tex)
	set_shader_param("has_albedo", tex != null)

func _get_metalic():
	return metalic

func _set_metalic(tex):
	metalic = tex
	set_shader_param("metalic", tex)
	set_shader_param("has_metalic", tex != null)

func _get_roughness():
	return roughness

func _set_roughness(tex):
	roughness = tex
	set_shader_param("roughness", tex)
	set_shader_param("has_roughness", tex != null)
	
func _get_ao():
	return ao

func _set_ao(tex):
	ao = tex
	set_shader_param("ao", tex)
	set_shader_param("has_ao", tex != null)

func _get_emission():
	return emission

func _set_emission(tex):
	emission = tex
	set_shader_param("emission", tex)
	set_shader_param("has_emission", tex != null)

func _get_normalmap():
	return normalmap

func _set_normalmap(tex):
	normalmap = tex
	set_shader_param("normalmap", tex)
	set_shader_param("has_normalmap", tex != null)

func _get_normalmap_scale():
	return normalmap_scale

func _set_normalmap_scale(sca):
	normalmap_scale = sca
	set_shader_param("normalmap_scale", sca)
