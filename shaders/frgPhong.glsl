#version 330
#extension GL_ARB_shading_language_420pack: enable

const int k = 3; // PCF filtering window
const int samples = (2 * k + 1) * (2 * k + 1); // PCF no. of samples

// this is a standard Phong fragment shader, plus
// shadow test using depth map

out vec3 fragcolor;

noperspective in vec3 _wnormal;
noperspective in vec3 _wcoord;

uniform mat4 world_to_light_projection;
uniform vec3 lloc;
uniform vec3 kd,ka,ks;
uniform float nspec;
uniform vec3 I,Ia;
uniform int reor;
uniform int texsize;

layout (binding=1) uniform sampler2D tex;

float depth_from_camera(vec4 a) {
  return 0.5 * ((a.z / a.w) + 1.);
}

float depth_from_light(vec2 pixel) {
	return texture(tex, pixel).r;
}

vec2 pixel_from_light(vec4 a) {
  return vec2(
    0.5 * (a.x / a.w + 1.0),
    0.5 * (a.y / a.w + 1.0)
  );
}

// percentage in shadow
float in_shadow(vec3 q) {
  vec4 a = world_to_light_projection * vec4(q, 1.);

  float camera_depth = depth_from_camera(a);

  vec2 tex_center = pixel_from_light(a);
  float tex_step = 1. / float(texsize);

  int times_closer = 0;
  for (int i = -k; i <= k; ++i) {
    for (int j = -k; j <= k; ++j) {
      vec2 t = tex_center + vec2(i, j) * tex_step;
      if (camera_depth <= depth_from_light(t))
        times_closer += 1;
    }
  }
  return float(times_closer) / float(samples);
}

void main() {
    vec3 N = reor*normalize(_wnormal);
    vec3 L = normalize(lloc-_wcoord);
    vec3 V = -normalize(_wcoord);
    vec3 H = normalize(L+V);

    float NdotL = dot(N,L);
    float HdotN = dot(H,N);

    if (NdotL<0) NdotL = 0.0;
    if (HdotN<0) HdotN = 0.0;

    fragcolor = ka*Ia +
      in_shadow(_wcoord) * (kd*NdotL + ks*pow(HdotN,nspec))*I;
}
