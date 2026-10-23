# NOSTROMO extras

Everything here is optional. Nothing in this folder is enabled by the theme.

## CRT shader

`crt.frag` adds subtle scanlines, a gentle barrel curve, and a vignette. It does
not shift the palette, so the phosphor green stays the color the theme defines.

Enable it live:

```bash
hyprctl keyword decoration:screen_shader \
  ~/.local/state/omarchy/current/theme/extras/crt.frag
```

Disable it:

```bash
hyprctl keyword decoration:screen_shader ""
```

Toggle it from a keybind. Add this to `~/.config/hypr/looknfeel.lua`:

```lua
o.bind("SUPER + SHIFT + F12", "Toggle CRT shader",
       "~/.local/state/omarchy/current/theme/extras/toggle-crt.sh")
```

`toggle-crt.sh` is the small script beside the shader; it reads the current
option with `hyprctl getoption` and flips it. Omarchy ships `jq`, which the
script uses.

To make it permanent, add the option to `~/.config/hypr/looknfeel.lua`:

```lua
hl.config({
  decoration = {
    screen_shader = os.getenv("HOME")
      .. "/.local/state/omarchy/current/theme/extras/crt.frag",
  },
})
```

Warnings:

- Curvature bends the edges of the screen, so screenshots and recordings are
  distorted.
- It costs a little GPU on every frame.
- On a multi-monitor setup the shader is applied per output by Hyprland; check
  the result on each monitor.

Tune `CURVATURE`, `SCANLINE_STRENGTH`, and `VIGNETTE` at the top of `crt.frag`.
Set `CURVATURE` to `0.0` if you want scanlines without any bending.

## Sounds

No audio is bundled. If you want a lock or notification chirp, wire your own
sound into the notification daemon or lock client you use; do not add files to
this folder expecting Omarchy to play them.
