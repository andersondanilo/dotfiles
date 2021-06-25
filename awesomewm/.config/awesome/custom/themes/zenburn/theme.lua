-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local theme_path = string.format("%s/.config/awesome/custom/themes/zenburn", os.getenv("HOME"))
local dpi = require("beautiful.xresources").apply_dpi
local Color = require("lib/luacolors")

local colors = {
    color_bg = "#282c34", -- brown
    color_primary = "#86A869", -- light green
    color_on_primary = "#353535", -- light green
    color_on_bg_light = "#b5c9ee", -- extreme light brown
    color_on_bg = "#96a6c5", -- light brown
    color_urgent = "#A6352E", -- red
}

colors.color_bg_inactive = Color.new(colors.color_bg):lighten_by(1.5):to_rgb()
colors.color_bg_dark = Color.new(colors.color_bg):lighten_by(0.8):to_rgb()
colors.color_bg_light = Color.new(colors.color_bg):lighten_by(1.3):to_rgb()
colors.color_bg_opacity = Color.new(colors.color_bg):lighten_by(2):to_rgb()
colors.color_on_bg_light_light = Color.new(colors.color_on_bg_light):lighten_by(1.3):to_rgb()

-- {{{ Main
local theme = {}
theme.wallpaper = string.format("%s/Pictures/Wallpapers/wallpaperflare.com_wallpaper.jpg", os.getenv("HOME"))
-- }}}

-- {{{ Styles
theme.font      = "NotoSans 8"

-- {{{ Colors
theme.fg_normal  = colors.color_on_bg_light
theme.fg_focus   = colors.color_on_primary
theme.fg_urgent  = colors.color_on_bg_light_light
theme.bg_normal  = colors.color_bg
theme.bg_focus   = colors.color_primary
theme.bg_urgent  = colors.color_urgent
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(0)
theme.border_width  = dpi(3)
theme.border_normal = colors.color_bg_inactive
theme.border_focus  = colors.color_bg_dark
theme.border_marked = colors.color_bg
-- }}}

-- {{{ Titlebars
theme.titlebar_fg_focus  = colors.color_on_bg
theme.titlebar_bg_focus  = colors.color_bg
theme.titlebar_fg_normal  = colors.color_on_bg
theme.titlebar_bg_normal = colors.color_bg_inactive
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme_path .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = theme_path .. "/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = theme_path .. "/awesome-icon.png"
theme.menu_submenu_icon      = theme_path .. "/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme_path .. "/layouts/tile.png"
theme.layout_tileleft   = theme_path .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme_path .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme_path .. "/layouts/tiletop.png"
theme.layout_fairv      = theme_path .. "/layouts/fairv.png"
theme.layout_fairh      = theme_path .. "/layouts/fairh.png"
theme.layout_spiral     = theme_path .. "/layouts/spiral.png"
theme.layout_dwindle    = theme_path .. "/layouts/dwindle.png"
theme.layout_max        = theme_path .. "/layouts/max.png"
theme.layout_fullscreen = theme_path .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme_path .. "/layouts/magnifier.png"
theme.layout_floating   = theme_path .. "/layouts/floating.png"
theme.layout_cornernw   = theme_path .. "/layouts/cornernw.png"
theme.layout_cornerne   = theme_path .. "/layouts/cornerne.png"
theme.layout_cornersw   = theme_path .. "/layouts/cornersw.png"
theme.layout_cornerse   = theme_path .. "/layouts/cornerse.png"
-- }}}

-- {{{ Systray
theme.systray_icon_spacing = 5
-- }}}
--
theme.tasklist_plain_task_name = false
theme.tasklist_shape_border_color = colors.color_bg_light

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme_path .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme_path .. "/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = theme_path .. "/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_path .. "/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = theme_path .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme_path .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme_path .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme_path .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme_path .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme_path .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme_path .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme_path .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme_path .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme_path .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme_path .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme_path .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme_path .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme_path .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme_path .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme_path .. "/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
