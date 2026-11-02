#version 330
// Raise the minimum alpha of st's background so light wallpapers do not
// wash out the text. Opaque text pixels are not changed.
in vec2 texcoord;
uniform sampler2D tex;
vec4 default_post_processing(vec4 c);

const float MIN_ALPHA = 0.40;  // 0.25 = st default here, 1.0 = fully opaque

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 c = texture2D(tex, texcoord / texsize, 0);
    float a = max(c.a, MIN_ALPHA);
    if (c.a > 0.0) c.rgb = c.rgb / c.a * a;  // picom colors are premultiplied
    c.a = a;
    return default_post_processing(c);
}
