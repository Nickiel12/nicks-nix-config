package.path = package.path .. ';/usr/local/share/lua/5.3/?.lua;/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;/usr/lib/lua/5.3/?.lua;/usr/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua;/home/nick/.luarocks/share/lua/5.3/?.lua;/home/nick/.luarocks/share/lua/5.3/?/init.lua;/usr/local/share/lua/5.3/?/init.lua;/home/nicholas/.luarocks/share/lua/5.3/?.lua;/home/nicholas/.luarocks/share/lua/5.3/?/init.lua'
package.cpath = package.cpath .. ';/usr/lib/lua/5.3/?.so;/usr/lib/lua/5.3/loadall.so;./?.so;/home/nick/.luarocks/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/?.so;/home/nicholas/.luarocks/lib/lua/5.3/?.so'

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling librarykey
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

local key_conf = require("key_conf")
local menu_conf = require("menu_conf")
local signals = require("signals")
local rules = require("window_rules")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_name = "galaxymenu"
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme_name ))
-- beautiful.wallpaper = string.format("%s/.config/awesome/themes/%s/wallpapers/earth2.png", os.getenv("HOME"), theme_name )

-- {{{ Function definitions

-- scan directory, and optionally filter outputs
function scandir(directory)
	local i, fileList, popen = 0, {}, io.popen
	for filename in popen([[find "]] ..directory.. [[" -type f]]):lines() do
	    i = i + 1
	    fileList[i] = filename
	end
	return fileList
end

-- }}}

-- configuration - edit to your liking
wp_timeout  = 180

-- simply put more pictures in this folder
wp_path = string.format("%s/.config/awesome/themes/%s/wallpapers/", os.getenv("HOME"), theme_name )
wp_filter = function(s) return string.match(s,"%.png$") end
wp_files = scandir(wp_path)
wp_index = math.random(1, #wp_files)

local rand_wllppr = function()

  -- set wallpaper to current index for all screens
  beautiful.wallpaper = wp_files[wp_index]
  gears.wallpaper.maximized(beautiful.wallpaper)

  -- stop the timer (we don't need multiple instances running at the same time)
  wp_timer:stop()

  -- get next random index
  wp_index = math.random( 1, #wp_files)

  --restart the timer
  wp_timer.timeout = wp_timeout
  wp_timer:start()
end
-- setup the timer
wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout", rand_wllppr)

-- initial start when rc.lua is first run
wp_timer:start()
rand_wllppr()


-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.floating,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

menu_conf.init(theme_dir, terminal, editor, editor_cmd)

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
awful.spawn.with_shell(string.format("%s/.config/autostart.sh", os.getenv("HOME")))
awful.spawn.with_shell(string.format("%s/.config/polybar/start_polybar.sh", os.getenv("HOME")))
-- XDG autostart
-- awful.spawn.with_shell(
--    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
--    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
--    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
--    )
