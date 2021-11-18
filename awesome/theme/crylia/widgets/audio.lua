------------------------------
-- This is the audio widget --
------------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("theme.crylia.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
require("Main.Signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "theme/crylia/assets/icons/audio/"

-- Returns the audio widget
return function ()

    local audio_widget = wibox.widget{
        {
            {
                {
                    {
                        {
                            id = "icon",
                            widget = wibox.widget.imagebox,
                            resize = false
                        },
                        id = "icon_layout",
                        widget = wibox.container.place
                    },
                    top = dpi(2),
                    widget = wibox.container.margin,
                    id = "icon_margin"
                },
                spacing = dpi(6),
                {
                    id = "label",
                    align = "center",
                    valign = "center",
                    widget = wibox.widget.textbox
                },
                id = "audio_layout",
                layout = wibox.layout.fixed.horizontal
            },
            id = "container",
            left = dpi(5),
            right = dpi(10),
            widget = wibox.container.margin
        },
        bg = color.color["Yellow200"],
        fg = color.color["Grey900"],
        shape = function (cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        widget = wibox.widget.background
    }

    local get_volume = function ()
        awful.spawn.easy_async_with_shell(
            [[ awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) ]],
            function (stdout)
                local icon = icondir .. "volume"
                stdout = stdout:gsub("%%", "")
                local volume = tonumber(stdout) or 0
                audio_widget.container.audio_layout.spacing = dpi(5)
                audio_widget.container.audio_layout.label.visible = true
                if volume < 1 then
                    icon = icon .. "-mute"
                    audio_widget.container.audio_layout.spacing = dpi(0)
                    audio_widget.container.audio_layout.label.visible = false
                elseif volume >= 1 and volume < 34 then
                    icon = icon .. "-low"
                elseif volume >= 34 and volume < 67 then
                    icon = icon .. "-medium"
                elseif volume >= 67 then
                    icon = icon .. "-high"
                end
                audio_widget.container.audio_layout.label:set_text(volume .. "%")
                audio_widget.container.audio_layout.icon_margin.icon_layout.icon:set_image(gears.color.recolor_image(icon .. ".svg", color.color["Grey900"]))
            end
        )
    end

    local check_muted = function ()
        awful.spawn.easy_async_with_shell(
            [[ awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master) ]],
            function (stdout)
                if stdout:match("off") then
                    audio_widget.container.audio_layout.label.visible = false
                    audio_widget.container:set_right(0)
                    audio_widget.container.audio_layout.icon_margin.icon_layout.icon:set_image(gears.color.recolor_image(icondir .. "volume-mute" .. ".svg", color.color["Grey900"]))
                else
                    audio_widget.container:set_right(10)
                    get_volume()
                end
            end
        )
    end

    -- Signals
    hover_signal(audio_widget, color.color["Yellow200"])

    audio_widget:connect_signal(
        "button::press",
        function ()
            awesome.emit_signal("widget::volume")
            awesome.emit_signal("module::volume_osd:show", true)
            awesome.emit_signal("module::slider:update")
            awesome.emit_signal("widget::volume_osd:rerun")
        end
    )

    awesome.connect_signal(
        "widget::volume",
        function (c)
            check_muted()
        end
    )

    check_muted()
    return audio_widget
end