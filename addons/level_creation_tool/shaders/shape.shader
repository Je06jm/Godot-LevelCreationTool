shader_type spatial;

uniform vec2 uv_offset;
uniform vec2 uv_scale = vec2(1.0);

uniform sampler2D albedo;
uniform sampler2D metalic;
uniform sampler2D roughness;
uniform sampler2D ao;
uniform sampler2D emission;
uniform sampler2D normalmap;
uniform float normalmap_scale;

uniform bool has_albedo;
uniform bool has_metalic;
uniform bool has_roughness;
uniform bool has_ao;
uniform bool has_emission;
uniform bool has_normalmap;

const int TYPE_BOX = 0;
const int TYPE_CYLINDER = 1;

uniform int type;

void vertex() {
	vec3 scale;
	scale.x = length(vec3(WORLD_MATRIX[0][0], WORLD_MATRIX[0][1], WORLD_MATRIX[0][2]));
	scale.y = length(vec3(WORLD_MATRIX[1][0], WORLD_MATRIX[1][1], WORLD_MATRIX[1][2]));
	scale.z = length(vec3(WORLD_MATRIX[2][0], WORLD_MATRIX[2][1], WORLD_MATRIX[2][2]));
	
	vec2 uv_top = UV * vec2(scale.x, scale.z) * uv_scale;
	vec2 uv_left = UV * vec2(scale.z, scale.y) * uv_scale;
	vec2 uv_front = UV * vec2(scale.x, scale.y) * uv_scale;
	vec2 uv_sides = UV * vec2((scale.z + scale.x) / 2.0, scale.y) * uv_scale;
	
	vec2 uv = vec2(0.0);
	
	if (type == TYPE_BOX) {
		uv += uv_top * abs(NORMAL.y);
		uv += uv_left * abs(NORMAL.x);
		uv += uv_front * abs(NORMAL.z);
	}
	else if (type == TYPE_CYLINDER) {
		uv += uv_top * abs(NORMAL.y);
		uv += uv_sides * (1.0 - abs(NORMAL.y));
	}
	
	uv += uv_offset;
	
	UV = uv;
}

void fragment() {
	if (has_albedo) {
		ALBEDO = texture(albedo, UV).rgb;
	}
	
	if (has_metalic) {
		METALLIC = texture(metalic, UV).r;
	}
	
	if (has_roughness) {
		ROUGHNESS = texture(roughness, UV).r;
	}
	
	if (has_ao) {
		AO = texture(ao, UV).r;
	}
	
	if (has_emission) {
		EMISSION = texture(emission, UV).rgb;
	}
	
	if (has_normalmap) {
		NORMALMAP = texture(normalmap, UV).xyz;
		NORMALMAP_DEPTH = normalmap_scale;
	}
}
