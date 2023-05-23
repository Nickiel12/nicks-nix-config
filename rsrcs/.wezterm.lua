-- A normal config version of my nix config for wezterm
local wezterm = require 'wezterm'
local config = {}

config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback {
        'DejaVu Sans Mono',
        'DejaVuSansMono-Nerd-Font',
        }
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = false

config.color_scheme = 'SeeThroughBlack'

config.color_schemes = {
    ['SeeThroughBlack'] = {
        ansi = {
            "#000000", "#E44B4B", "#00cd00", "#cdcd00",
            "#0091f1", "#cd00cd", "#00cdcd", "#faebd7"
        },
        brights = {
        "#404040", "#ff0000", "#00ff00", "#ffff00",
        "#48b3fb", "#ff00ff", "#00ffff", "#ffffff"
        },
        foreground = "#F4EFD6",
        background = "#202020",

        cursor_bg = "#2CCCE4",
        cursor_border = "#2CCCE4" ,

        selection_bg = "#8ED1FC",
        selection_fg = "black",
    }
}

return config
