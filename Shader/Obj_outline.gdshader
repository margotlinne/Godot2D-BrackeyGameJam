shader_type canvas_item;

uniform float outline_width : hint_range(0.0, 10.0) = 4.0;
uniform float progress : hint_range(0.0, 1.0);
uniform vec4 outline_color : source_color;

void fragment() {
    // 텍스처의 해상도와 텍스처 크기에 따라 픽셀 크기를 계산합니다.
    float size = outline_width / float(textureSize(TEXTURE, 0).x);

    // 현재 픽셀의 색상과 알파 값을 가져옵니다.
    vec4 sprite_color = texture(TEXTURE, UV);
    float alpha = sprite_color.a;

    // 주변 픽셀의 알파 값을 더해 아웃라인을 계산합니다.
    alpha += texture(TEXTURE, UV + vec2(size, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(-size, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, size)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, -size)).a;
    alpha += texture(TEXTURE, UV + vec2(size, size)).a;
    alpha += texture(TEXTURE, UV + vec2(-size, -size)).a;
    alpha += texture(TEXTURE, UV + vec2(-size, size)).a;
    alpha += texture(TEXTURE, UV + vec2(size, -size)).a;

    // 아웃라인 색상과 알파를 `progress`에 따라 조절합니다.
    vec4 final_color = mix(outline_color, sprite_color, sprite_color.a);
    COLOR = vec4(final_color.rgb, clamp(alpha * progress + sprite_color.a, 0.0, 1.0));
}
