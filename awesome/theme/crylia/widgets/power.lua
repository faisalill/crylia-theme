--------------------------------
-- This is the power widget --
--------------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("theme.crylia.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
require("Main.Signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "theme/crylia/assets/icons/power/"

return function ()

    local power_widget = wibox.widget{
        {
            {
                {
                    {
                        {
                            id = "icon",
                            image = gears.color.recolor_image(icondir .. "power.svg", color.color["Grey900"]),
                            widget = wibox.widget.imagebox,
                            resize = false
                        },
                        id = "icon_layout",
                        widget = wibox.container.place
                    },
                    id = "icon_margin",
                    top = dpi(2),
                    widget = wibox.container.margin
                },
                id = "power_layout",
                layout = wibox.layout.fixed.horizontal
            },
            id = "container",
            left = dpi(5),
            right = dpi(5),
            widget = wibox.container.margin
        },
        bg = color.color["Red200"],
        fg = color.color["Grey800"],
        shape = function (cr, width, height)
            gears.shape.rounded_rect(cr, height, width, 5)
        end,
        widget = wibox.widget.background
    }

    -- Signals
    hover_signal(power_widget, color.color["Red200"])

    power_widget:connect_signal(
        "button::release",
        function ()
            awesome.emit_signal("module::powermenu:show")
        end
    )

    return power_widget
end