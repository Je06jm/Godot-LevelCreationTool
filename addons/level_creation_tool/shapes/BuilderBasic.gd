tool
extends MeshInstance
class_name BuilderBasic

export(ShaderMaterial) var material : ShaderMaterial = null setget _set_material
export(Vector2) var uv_offset := Vector2.ZERO setget _set_uv_offset
export(Vector2) var uv_scale := Vector2.ONE setget _set_uv_scale
export(float) var lightmap_size := 0.0 setget _set_lightmap_size
export(bool) var enable_collisions := true setget _set_enable_collisions

var _mat
var _body : StaticBody = null

enum {
	TYPE_NONE = -1,
	TYPE_BOX = 0,
	TYPE_CYLINDER = 1
}

func get_mesh_type():
	return TYPE_NONE

func get_mesh():
	return null

func _init():
	use_in_baked_light = true
	mesh = get_mesh().duplicate(true)

func _ready():
	if not Engine.editor_hint and enable_collisions:
		_body = create_trimesh_collision()

func _set_material(mat):
	if mat != null:
		material = mat.duplicate()
		_mat = material
		_mat.set_shader_param("uv_offset", uv_offset)
		_mat.set_shader_param("uv_scale", uv_scale)
		_mat.set_shader_param("type", get_mesh_type())
		
		mesh.surface_set_material(0, _mat)
	
	else:
		_mat = null
		material = null
	
	mesh.lightmap_size_hint = Vector2(lightmap_size, lightmap_size)

func _set_uv_offset(uv):
	uv.x = fmod(fmod(uv.x, 1.0) + 1.0, 1.0)
	uv.y = fmod(fmod(uv.y, 1.0) + 1.0, 1.0)
	
	uv_offset = uv
	
	if _mat != null:
		_mat.set_shader_param("uv_offset", uv)

func _set_uv_scale(uv):
	uv_scale = uv
	
	if _mat != null:
		_mat.set_shader_param("uv_scale", uv)

func _set_lightmap_size(size):
	size = max(size, 0.0)
	
	lightmap_size = size
	
	mesh.lightmap_size_hint = Vector2(size, size)

func _set_enable_collisions(enable):
	enable_collisions = enable
