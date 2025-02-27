shader_type spatial;

uniform float sway_strength : hint_range(0.0, 0.2) = 0.05;
uniform float sway_speed : hint_range(0.0, 5.0) = 1.5;

uniform sampler2D albedo_texture;


void vertex() {
    // Apply sway effect based on time and vertex position (Y-axis)
    float sway = sin(TIME * sway_speed + VERTEX.y) * sway_strength;
    VERTEX.x += sway;  // Apply sway to the X-axis (or modify Y for vertical sway)
}

void fragment() {
    // Sample from the texture
    vec4 albedo_tex = texture(albedo_texture, UV);
    ALBEDO = albedo_tex.rgb; // Preserve the RGB texture color
    ALPHA = albedo_tex.a;    // Preserve transparency
}
