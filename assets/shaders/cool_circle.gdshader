shader_type canvas_item;


uniform float amt : hint_range(0.0, 1.0);
uniform float outline:hint_range(0.5, 1.0);
uniform float edge_softness = 0.0;
uniform vec4 color : hint_color;
uniform vec4 stroke_color:hint_color;


void fragment() 
{
	vec4 color_tex = texture(TEXTURE, UV);
	float radius = amt * 0.5;
	float outline_radius = radius * outline;
	float d = distance(UV, vec2(0.5));
	float circle = smoothstep(d - edge_softness, d, radius - edge_softness);
	float circ2 = smoothstep(d - edge_softness, d, outline_radius - edge_softness);
	vec4 fill_color = vec4(color.rgb, circle);
	vec4 out_color =  vec4(stroke_color.rgb, circ2);
	COLOR = out_color + fill_color;
}
void vertex() {
	VERTEX.y += sin(TIME*2.0) * 5.0;
}