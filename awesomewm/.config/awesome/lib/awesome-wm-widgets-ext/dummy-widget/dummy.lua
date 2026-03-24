local awful = require("awful")
local wibox = require("wibox")

local dummy_widget = {}

local function worker(user_args)
    local args = user_args or {}

    dummy_widget.widget = wibox.widget {
        {
            id = 'txt',
            font = font,
            widget = wibox.widget.textbox
        },
        spacing = 4,
        layout = wibox.layout.fixed.horizontal
    }

    return dummy_widget.widget
end

return setmetatable(dummy_widget, { __call = function(_, ...)
    return worker(...)
end })
