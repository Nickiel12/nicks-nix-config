
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local menubar = require("menubar")
local cpu_widget = require("cpu-widget")
local battery_widget = require("batteryarc")
local ram_widget = require("ram-widget")

-- Mod+p for a simple .desktop thing, probably not going to use
local vicious = require("vicious")

local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local menu_conf = {}

menu_conf.init = function(
    theme_dir, terminal, editor, editor_cmd)

    beautiful.init(theme_dir)

    -- {{{ Menu
    -- Create a launcher widget and a main menu
    myawesomemenu = {
        { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "manual", terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awesome.conffile },
        { "restart", awesome.restart },
        -- { "quit", function() awesome.quit() end },
    }

    mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                { "open terminal", terminal }
            }
        })

    mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
        menu = mymainmenu })

    -- Menubar configuration
    menubar.utils.terminal = terminal -- Set the terminal for applications that require it
    -- }}}

    -- {{{ Wibar
    -- Create a textclock widget
    mytextclock = wibox.widget.background()
    mytextclock:set_widget(awful.widget.textclock())
    mytextclock:set_bg(beautiful.bg_normal)


    -- Create a wibox for each screen and add it
    local taglist_buttons = gears.table.join(
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                if client.focus then
                                    client.focus:move_to_tag(t)
                                end
                            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                if client.focus then
                                    client.focus:toggle_tag(t)
                                end
                            end),
            awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
            )

    local tasklist_buttons = gears.table.join(
            awful.button({ }, 1, function (c)
                                if c == client.focus then
                                    c.minimized = true
                                else
                                    c:emit_signal(
                                        "request::activate",
                                        "tasklist",
                                        {raise = true}
                                    )
                                end
                            end),
            awful.button({ }, 3, function()
                                awful.menu.client_list({ theme = { width = 250 } })
                            end),
            awful.button({ }, 4, function ()
                                awful.client.focus.byidx(1)
                            end),
            awful.button({ }, 5, function ()
                            awful.client.focus.byidx(-1)
                            end))

    local function set_wallpaper(s)
        -- Wallpaper
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end
    
    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)
    
    awful.screen.connect_for_each_screen(function(s)
        -- Wallpaper
        set_wallpaper(s)

        -- Each screen has its own tag table.
        awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
    
        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        local layoutbox = awful.widget.layoutbox(s)
        layoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))
        
        s.mylayoutbox = wibox.widget.background()
        s.mylayoutbox:set_widget(layoutbox)
        s.mypromptbox = awful.widget.prompt()

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,
        }

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            layout = {
                spacing = 0,
                layout = wibox.layout.flex.horizontal,
            },
            widget_template = {
                {
                    {
                        {
                            {
                                id     = 'icon_role',
                                widget = wibox.widget.imagebox,
                            },  
                            margins = 0,
                            widget = wibox.container.margin,
                        },
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left  = 20,
                    right = 20,
                    widget = wibox.container.margin,
                },  
                id    = 'background_role',
                widget = wibox.container.background,
            },
        }

        s.battery_widget = wibox.widget {
            battery_widget({
                show_current_level = true,
                bg_color = "#ff0000",
                size = 30,
                arc_thickness = 3,
            }),
            bg = beautiful.bg_normal,
            widget = wibox.container.background,
        }

        s.cpu_widget = cpu_widget({
            width = 70,
            step_width = 2,
            step_spacing = 0,
            color = '#434c9e',
            background_color = beautiful.bg_normal,
        })

        s.ram_widget = wibox.widget {
            ram_widget({
                --color_used=
                --color_buf=
                --color_free=
                widget_width=35,
                widget_height=35,
                widget_show_buf=true,
            }),
            bg = beautiful.bg_normal,
            widget = wibox.container.background,
        }


        function left_endpoint_shape(cr, width, height)
           -- insert custom shape building here:
             gears.shape.transform(gears.shape.rectangular_tag) 
                : translate(0, -height) 
                    (cr, width, height*2, width)
        end

        function right_endpoint_shape(cr, width, height)
            -- insert custom shape building here:
            gears.shape.transform(gears.shape.rectangular_tag) 
                : rotate_at(width/2, height, math.pi)
                    : translate(0, height) 
                    (cr, width, height*2, width)
        end

        -- Custom Widget the makes the left-side angle
        local left_endpoint = {
            {
                {
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            bg = beautiful.bg_normal,
            forced_width = beautiful.menu_height,
            shape = left_endpoint_shape,
            widget = wibox.container.background,
        }
      
        -- Custom widget that makes the right-side angle
        local right_endpoint = {
            {
                {
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            bg = beautiful.bg_normal,
            forced_width = beautiful.menu_height,
            shape = right_endpoint_shape,
            widget = wibox.container.background,
        }

        -- Create the wibox
        s.mywibox = awful.wibar({ 
            position = "top",
            screen = s,
            bg = beautiful.bg_systray
        })

        -- Add widgets to the wibox
        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,

                mylauncher,
                s.mytaglist,
                s.mypromptbox,
                right_endpoint,
            },
            {
                layout = wibox.layout.fixed.horizontal,

                left_endpoint,
                s.mytasklist, -- Middle widget
                right_endpoint,
            },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,

                left_endpoint,
                s.cpu_widget,
                s.ram_widget,
                s.battery_widget,
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
            },
        }
    end)  
    -- }}}
end 

return menu_conf
