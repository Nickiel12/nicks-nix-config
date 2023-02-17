
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
local create_titlebar = function(c, is_floating)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local my_close_btn = awful.titlebar.widget.closebutton(c)
    -- The part that actually removes the tooltip
    my_close_btn._private.tooltip:remove_from_object(my_close_btn)
    
    local defenstrate_tooltip = awful.tooltip { }
    defenstrate_tooltip:add_to_object(my_close_btn)
    my_close_btn:connect_signal('mouse::enter', function()
        defenstrate_tooltip.text = "Defenstrate"
    end)

    function drag_bar_shape(cr, width, height) 
        local radius = 10
        gears.shape.rounded_rect(cr, width, height, radius)
    end

    if (is_floating) 
    then
        awful.titlebar(c) : setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                --awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                my_close_btn,
                --awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    else
        awful.titlebar(c, { 
            size = beautiful.tiled_titlebar_height,
            bg_normal = beautiful.tiled_titlebar_bg_normal,
            bg_focus  = beautiful.tiled_titlebar_bg_focus,
        }) : setup {
            {
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                {
                    {
                        {
                            widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.flex.horizontal,
                    },
                    bg = beautiful.tiled_titlebar_center,
                    forced_width = 80,
                    shape = drag_bar_shape,
                    widget = wibox.container.background,
                },
                layout = wibox.layout.align.horizontal,
                buttons = buttons,
            },
            { -- Right
                layout = wibox.layout.fixed.horizontal()
            },
            expand = "outside",
            layout = wibox.layout.align.horizontal
        }
    end
end

client.connect_signal("request::titlebars", function(c) 
    create_titlebar(c, true)
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

client.connect_signal("property::floating", function(c)
    if c.floating then
        --awful.titlebar.show(c)
        create_titlebar(c, true)
    else 
        --awful.titlebar.hide(c)
        create_titlebar(c, false)
    end
end)

function dynamic_title(c)
    if c.floating or c.first_tag.layout.name == "floating" then
        --awful.titlebar.show(c)
        create_titlebar(c, true)
    else
        --awful.titlebar.hide(c)
        create_titlebar(c, false)
    end
end

tag.connect_signal("property::layout", function(t)
    local clients = t:clients()
    for k,c in pairs(clients) do
        if c.floating or c.first_tag.layout.name == "floating" then
            --awful.titlebar.show(c)
            create_titlebar(c, true)
        else
            --awful.titlebar.hide(c)
            create_titlebar(c, false)
        end
    end
end)

client.connect_signal("manage", dynamic_title)
client.connect_signal("tagged", dynamic_title)
