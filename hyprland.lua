-- NOSTROMO — Omarchy 4.x Hyprland overrides.
--
-- Loaded after Omarchy's defaults as omarchy.current.theme.hyprland.
-- Square corners, opaque windows, no blur, no shadows, thin phosphor borders.
-- Note: omarchy-theme-install drops .lua files from cloned themes; for installed
-- copies the generated hyprland.lua reads hyprland_active_border and
-- hyprland_inactive_border from colors.toml instead.

local active_border   = "rgba(7dff8aee)"
local inactive_border = "rgba(2f7a3aee)"

hl.config({
  general = {
    col = {
      active_border   = active_border,
      inactive_border = inactive_border,
    },
    gaps_in     = 4,
    gaps_out    = 8,
    border_size = 2,
  },

  group = {
    col = {
      border_active   = active_border,
      border_inactive = inactive_border,
    },
    groupbar = {
      col = {
        active   = "rgba(7dff8a2e)",
        inactive = "rgba(2f7a3a1f)",
      },
      text_color          = "rgb(5fd16b)",
      text_color_inactive = "rgb(2f7a3a)",
      font_family         = "monospace",
      font_size           = 11,
      height              = 22,
    },
  },

  decoration = {
    rounding         = 0,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    dim_inactive     = false,
    shadow = {
      enabled = false,
    },
    blur = {
      enabled = false,
    },
  },
})
