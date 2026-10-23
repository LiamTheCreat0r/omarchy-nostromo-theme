-- NOSTROMO — Neovim colors.
--
-- Uses aether.nvim, Omarchy's own theme engine, pinned to the Nostromo palette.
-- Omarchy 4 regenerates this file from colors.toml when a theme is installed
-- from a git repo; this copy is for manual/local installs and for reference.

return {
  {
    "omacom/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg = "#0a0c09",
        dark_bg = "#070908",
        darker_bg = "#040504",
        lighter_bg = "#141812",

        fg = "#5fd16b",
        dark_fg = "#2f7a3a",
        light_fg = "#c9bfa5",
        bright_fg = "#7dff8a",
        muted = "#43994f",

        red = "#ff5f1f",
        yellow = "#ffb000",
        orange = "#ff8a50",
        green = "#7dff8a",
        cyan = "#5fb8a8",
        blue = "#4a8f89",
        magenta = "#b58a5a",
        brown = "#8a6540",

        bright_red = "#ff8a50",
        bright_yellow = "#ffd060",
        bright_green = "#a6ffae",
        bright_cyan = "#8fd8cc",
        bright_blue = "#5fa8a0",
        bright_magenta = "#d9b88a",

        accent = "#7dff8a",
        cursor = "#7dff8a",
        foreground = "#5fd16b",
        background = "#0a0c09",
        selection = "#1b2a1d",
        selection_foreground = "#0a0c09",
        selection_background = "#7dff8a",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
