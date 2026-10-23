# NOSTROMO extras

Everything here is optional. Nothing in this folder is enabled by the theme.

## Font

The theme bundles Blex Mono (IBM Plex Mono) in `../fonts/`. Omarchy never runs
scripts from a theme directory and never scans one for fonts, so registration is
a separate step:

```bash
~/.local/state/omarchy/current/theme/extras/install-font.sh
```

`install-font.sh` copies the two faces into `~/.local/share/fonts`, runs
`fc-cache`, verifies fontconfig sees them, and calls
`omarchy font set "BlexMono Nerd Font Mono"`. It exits early if Blex is already
the monospace font, so it is safe to run again.

To automate it, copy the example hook into your own hooks directory:

```bash
install -Dm755 ~/.local/state/omarchy/current/theme/extras/theme-set.example \
  ~/.config/omarchy/hooks/theme-set
```

Omarchy runs `~/.config/omarchy/hooks/theme-set <theme-name>` after every theme
change. The example exits unless the theme is `nostromo`, then runs the install
script. Delete the file to stop the automation.

Warnings:

- `omarchy font set` is global, not per theme. It writes the fontconfig
  `monospace` alias to `~/.config/fontconfig/fonts.conf` and restarts the shell.
  Switching to another theme keeps Blex Mono selected.
- `omarchy theme update` only pulls the repository. Run
  `omarchy theme set nostromo` afterwards to restage the files.

Manual fallback:

```bash
install -m 644 ~/.local/state/omarchy/current/theme/fonts/*.ttf \
  ~/.local/share/fonts/
fc-cache -f
omarchy font set "BlexMono Nerd Font Mono"
```

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
