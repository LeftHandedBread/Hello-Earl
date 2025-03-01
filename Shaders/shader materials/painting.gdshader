shader_type spatial;

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform sampler2D normal_map;
uniform float blend_factor : hint_range(0.0, 1.0);

void fragment() {
    vec4 color1 = texture(texture1, UV);
    vec4 color2 = texture(texture2, UV);
    
    vec4 final_color = mix(color1, color2, blend_factor);
    
    // Correcting the color to avoid blue tint and washed-out appearance
    final_color.rgb = pow(final_color.rgb, vec3(2.2)); // Apply gamma correction
    
    ALBEDO = final_color.rgb;
    ALPHA = final_color.a;
    
    // Normal map processing
    vec3 normal_tex = texture(normal_map, UV).rgb * 2.0 - 1.0;
    NORMAL = normalize(normal_tex);
}
