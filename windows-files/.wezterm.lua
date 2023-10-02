-- Put in $HOME directory

-- A normal config version of my nix config for wezterm
local wezterm = require 'wezterm'
local config = {}

-- Requires powershell 7, and dejavu sans mono
-- for starship prompt, see: https://starship.rs/guide/#%F0%9F%9A%80-installation and powershell installation
config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }

config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback {
        'DejaVu Sans Mono',
        'DejaVuSansMono-Nerd-Font',
        }
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true

--config.color_scheme = 'SeeThroughBlack'
 config.color_scheme = 'Catppuccin Latte'

--config.window_background_opacity = 0
--config.win32_system_backdrop = "Acrylic"


config.color_schemes = {
    ['SeeThroughBlack'] = {
        ansi = {
            "#000000", "#E44B4B", "#00cd00", "#cdcd00",
            "#0091f1", "#cd00cd", "#00cdcd", "#faebd7"
        },
        brights = {
        "#404040", "#ff4a4a", "#04b004", "#ffff7f",
        "#48b3fb", "#ff00ff", "#73ffe6", "#ffffff"
        },
        -- foreground = "#F4EFD6",
        -- background = "#202020",
        foreground = "black",
        background = "#000000",

        cursor_bg = "#1C6CD4",
        cursor_border = "1C6CE4" ,

        selection_bg = "#8ED1FC",
        selection_fg = "black",
    }
}

return config
