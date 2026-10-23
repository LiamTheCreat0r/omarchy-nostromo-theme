#version 300 es
//
// NOSTROMO — optional CRT post-processing shader.
//
// Subtle scanlines, a gentle barrel curve, and a soft vignette. No color
// shifts: the palette stays exactly as the theme defines it.
//
// Enable with:
//   hyprctl keyword decoration:screen_shader
//     ~/.local/state/omarchy/current/theme/extras/crt.frag
// Disable with:
//   hyprctl keyword decoration:screen_shader ""
//
// Curvature distorts screenshots and costs a little GPU. Not enabled by
// default. Tune the constants below if you want it stronger or weaker.

precision mediump float;

in vec2 v_texcoord;
layout(location = 0) out vec4 fragColor;

uniform sampler2D tex;

const float CURVATURE        = 0.035;
const float SCANLINE_STRENGTH = 0.085;
const float SCANLINE_PERIOD   = 3.0;
const float VIGNETTE          = 0.55;

vec2 barrel(vec2 uv) {
  vec2 p = uv * 2.0 - 1.0;
  p += p * dot(p, p) * CURVATURE;
  return p * 0.5 + 0.5;
}

void main() {
  vec2 uv = barrel(v_texcoord);

  // Outside the curved frame: opaque black, matching the theme background.
  if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
    fragColor = vec4(0.039, 0.047, 0.035, 1.0);
    return;
  }

  vec4 pix = texture(tex, uv);

  // Horizontal scanlines, one dark line every SCANLINE_PERIOD pixels.
  vec2 size = vec2(textureSize(tex, 0));
  float line = 0.5 + 0.5 * cos(uv.y * size.y * 6.2831853 / SCANLINE_PERIOD);
  pix.rgb *= 1.0 - SCANLINE_STRENGTH * line;

  // Soft radial vignette.
  vec2 d = uv - 0.5;
  pix.rgb *= clamp(1.0 - dot(d, d) * VIGNETTE, 0.0, 1.0);

  fragColor = pix;
}
