shader_type spatial;
render_mode unshaded, diffuse_lambert;

uniform sampler2D NoiseTexture;
uniform vec4 color : hint_color;
uniform float passVal;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment(){
	if (texture(NoiseTexture, UV).r < (COLOR.r * passVal)){
		discard;
	}
	ALBEDO = (COLOR * passVal * color).rgb;
}

void light(){
	DIFFUSE_LIGHT += clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION * ALBEDO;
}