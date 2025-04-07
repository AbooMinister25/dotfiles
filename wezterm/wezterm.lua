local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_wayland = false
config.color_scheme = 'Everforest (Custom)'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.font_size = 11

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = "#2D353B",
      fg_color = "#D3C6AA",
    },
    inactive_tab = {
      bg_color = "#3D484D",
      fg_color = "#D3C6AA",
    },
    inactive_tab_hover = {
      bg_color = "#232A2E",
      fg_color = "#D3C6AA",
    },
    new_tab = {
      bg_color = "#2D353B",
      fg_color = "#D3C6AA",
    },
    new_tab_hover = {
      bg_color = "#232A2E",
      fg_color = "#D3C6AA",
    },
  }
}

config.window_frame = {
  active_titlebar_bg = "2D353B"
}

config.window_padding = {
  left = "3cell",
  right = "3cell",
  top = "1cell",
  bottom = "1cell",
}

return config
