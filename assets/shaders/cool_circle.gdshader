shader_type canvas_item;


uniform float amt : hint_range(0.0, 1.0);
uniform float edge_softness = 0.0;
uniform vec4 color : hint_color;


void fragment() 
{
	vec4 color_tex = texture(TEXTURE, UV);
	float radius = amt * 0.5;
	float d = distance(UV, vec2(0.5));
	float circle = smoothstep(d - edge_softness, d, radius - edge_softness);
	float circ2 = smoothstep(d - edge_softness, d, radius * 0.9 - edge_softness);
	COLOR = vec4(color.rgb, circle);
}