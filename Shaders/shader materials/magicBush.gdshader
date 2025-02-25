shader_type canvas_item;

render_mode light_only;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
}

void light() {
LIGHT = mix(
vec4(0.0),
vec4(LIGHT_COLOR. rgb * COLOR. rgb * LIGHT_ENERGY, LIGHT_COLOR.a),
step(LIGHT_COLOR.r,0.0)
);
}
