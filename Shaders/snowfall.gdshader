shader_type canvas_item;

uniform float layers : hint_range(1.0, 200.0, 1.0) = 50.0;
uniform float depth  : hint_range(0.0, 1.0, 0.1)  = 0.5;
uniform float density: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float speed  : hint_range(0.0, 1.0, 0.1)  = 0.5;
uniform float wind   : hint_range(-2.0, 2.0, 0.01)= 0.0;

vec3 hash33(vec3 p) {
	p = fract(p * 0.1031);
	p += dot(p, p.yzx + 33.33);
	return fract((p.xxy + p.yzz) * p.zyx);
}

void fragment() {
	vec2 uv = -UV;
	vec2 resolution = 1.0 / TEXTURE_PIXEL_SIZE;
	uv.x *= resolution.x / resolution.y;

	float time = TIME * speed;
	vec3 snow = vec3(0.0);

	const int MAX_LAYERS = 200;

	for (int li = 0; li < MAX_LAYERS; li++) {
		float i = float(li);
		if (i >= layers) {
			break;
		}

		// Snowflake position
		vec2 flake = uv * (1.0 + i * depth);

		float wind_shift = density * (mod(i * PI, 1.0) - (wind + 0.5));
		float fall = time / (1.0 + i * depth * 0.03);

		flake += vec2(flake.y * wind_shift, fall);

		// Per-flake randomness
		vec3 tile_id = vec3(floor(flake), i);
		vec3 flake_shift = hash33(tile_id);

		// Base flake shape
		vec2 shape = abs(mod(flake, 1.0) - 1.0 + flake_shift.xy);
		shape += 0.01 * abs(2.0 * fract(10.0 * flake) - 1.0);

		float dist = 0.5 * max(shape.x - shape.y, shape.x + shape.y)
		           + max(shape.x, shape.y) - 0.01;

		float edge = 0.05 * min(0.5 * abs(i - 5.0), 1.0);

		float flake_intensity =
			smoothstep(edge, -edge, dist) *
			(flake_shift.x / (1.0 + 0.02 * i * depth));

		snow += vec3(flake_intensity);
	}

	float alpha = clamp(length(snow), 0.0, 1.0);
	COLOR = vec4(vec3(alpha), alpha);
}
