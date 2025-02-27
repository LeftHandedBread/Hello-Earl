shader_type spatial;

uniform float sway_speed : hint_range(0.0, 5.0) = 1.0;
uniform float sway_amount : hint_range(0.0, 1.0) = 0.1;
uniform float rotation_speed : hint_range(0.0, 5.0) = 1.0;
uniform float rotation_amount : hint_range(0.0, 1.0) = 10.0;

void vertex() {
    // Time-based sway offset for movement in x and y directions
    vec3 sway_offset = vec3(sin(TIME * sway_speed + VERTEX.x * 0.1) * sway_amount,
                            cos(TIME * sway_speed + VERTEX.y * 0.1) * sway_amount,
                            0.0);

    // Apply sway offset to the vertex position
    VERTEX.xyz += sway_offset;

    // Apply rotation to simulate leaf spin (2D rotation matrix)
    float rotation_angle = sin(TIME * rotation_speed + VERTEX.x * 0.2) * rotation_amount;
    mat2 rotation_matrix = mat2(cos(rotation_angle), -sin(rotation_angle),
                                sin(rotation_angle), cos(rotation_angle));

    // Rotate the vertex around the Z-axis (only modifying x and y components)
    VERTEX.xy = (rotation_matrix * VERTEX.xy);
}
