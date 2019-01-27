shader_type canvas_item;

void fragment()
{
	vec4 temp_color = texture(TEXTURE,UV);
	temp_color.a = 0.8;
	COLOR = temp_color;
}