-- BASED ON '/etc/xdg/awesome/rc.lua'
--
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- ext
-- local pomodoro_widget = require("lib/openpomodoro-awesomewm")
local volume_widget = require('lib.awesome-wm-widgets-ext.volume-widget.volume')
local battery_widget = require("lib.awesome-wm-widgets-ext..battery-widget.battery")
local brightness_widget = require("lib.awesome-wm-widgets-ext.brightness-widget.brightness")

sharedtags = require("lib.awesome-sharedtags")

tags = sharedtags({
    { name = "1", layout = awful.layout.layouts[1] },
    { name = "2", layout = awful.layout.layouts[1] },
    { name = "3", layout = awful.layout.layouts[1] },
    { name = "4", layout = awful.layout.layouts[1] },
    { name = "5", layout = awful.layout.layouts[1] },
    { name = "6", layout = awful.layout.layouts[1] },
    { name = "7", layout = awful.layout.layouts[1] },
    { name = "8", layout = awful.layout.layouts[1] },
    { name = "9", layout = awful.layout.layouts[1] },
    -- { screen = 2, layout = awful.layout.layouts[2] }
})

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
-- beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")
-- local chosen_theme = "vertez"
beautiful.init(string.format("%s/.config/awesome/custom/themes/zenburn/theme.lua", os.getenv("HOME")))

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
terminal_tmux = terminal .. " -e 'tmux new-session \\; set-option destroy-unattached'"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

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

local mysystray = wibox.widget.systray()

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    -- s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                     id     = 'text_role',
                     widget = wibox.widget.textbox,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout   = {
           spacing_widget = {
               {
                   forced_width  = 5,
                   forced_height = 24,
                   thickness     = 1,
                   color         = beautiful.tasklist_shape_border_color,
                   widget        = wibox.widget.separator
               },
               valign = 'center',
               halign = 'center',
               widget = wibox.container.place,
           },
           spacing = 1,
           layout  = wibox.layout.fixed.horizontal
       },
       -- Notice that there is *NO* wibox.wibox prefix, it is a template,
       -- not a widget instance.
       widget_template = {
          {
              {
                  {
                      {
                          id     = 'icon_role',
                          widget = wibox.widget.imagebox,
                      },
                      margins = 2,
                      widget  = wibox.container.margin,
                  },
                  {
                      id     = 'text_role',
                      widget = wibox.widget.textbox,
                      forced_width = 100
                  },
                  layout = wibox.layout.fixed.horizontal,
              },
              left  = 10,
              right = 10,
              widget = wibox.container.margin
          },
          id     = 'background_role',
          widget = wibox.container.background,
       },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
       position = "top",
       screen = s,
       height = 28
    })

    local widget_separator = wibox.widget.textbox("  ")

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            {
                layout = wibox.layout.align.horizontal,
                forced_width = 1
            }
        },
        s.mytasklist, -- Middle widget
        wibox.container.margin(wibox.widget { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            {
               layout = wibox.layout.fixed.horizontal,
               spacing = beautiful.systray_icon_spacing,
               volume_widget{
                   widget_type = 'icon_and_text'
               },
               brightness_widget{
                   type = 'arc',
                   program = 'brightnessctl',
                   step = 2,
               },
               battery_widget{
                  path_to_icons="/usr/share/icons/oomox-CustomOneHalf/22/status/"
               },
               mysystray,
            },
            mytextclock,
        }, 0, 0, 5, 5)
    }
end)
-- }}}


clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- {{ Custom
require("custom/keybindings")
require("custom/autostart")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    { rule_any = {class = { "Alacritty" }
      }, properties = { titlebars_enabled = false }
    },

    { rule_any = {class = { "pomotroid" }
      }, properties = { titlebars_enabled = false }
    },

    { rule = { class = "firefox" },
      properties = { maximized = true, titlebars_enabled = false } },

    { rule = { class = "Spotify" },
      properties = { maximized = true, tag = tags["9"] } },

    {
        rule = {
            class = "jetbrains-studio",
            name="^win[0-9]+$"
        },
        properties = { 
            placement = awful.placement.no_offscreen,
            titlebars_enabled = false
        }
    },
}
-- }}}

local function on_maximized_set_or_change(c, is_change)
   print("on_maximized_set_or_change")

   --if c.maximized then
   --   awful.titlebar.hide(c)
   --else
   --   awful.titlebar.show(c)
   --end
end

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    -- print("signal manage")
    -- print("is floating: " .. tostring(c.floating))
    -- print("user_position: " .. tostring(c.size_hints.user_position))
    -- print("program_position: " .. tostring(c.size_hints.program_position))
    -- print("c.maximized: " .. tostring(c.maximized))
    -- print("c.class: " .. tostring(c.class))
    -- print("c.name: " .. tostring(c.name))
    -- print("c.role: " .. tostring(c.role))
    -- print("c.type: " .. tostring(c.type))
    -- print("c.window: " .. tostring(c.window))
    -- print("c.maximized_vertical: " .. tostring(c.maximized_vertical))
    -- print("c.maximized_horizontal: " .. tostring(c.maximized_horizontal))
    -- print("c.geometry: " .. tostring(c.geometry))
    -- print("c.role: " .. tostring(c.role))
    -- print("c.window: " .. tostring(c.window))
    -- print("c.screen.geometry.width: " .. tostring(c.screen.geometry.width))
    -- print("c.screen.geometry.height: " .. tostring(c.screen.geometry.height))
    -- print("c.screen.width: " .. tostring(c.screen.width))
    -- print("c.motif_wm_hints: " .. tostring(c.motif_wm_hints))
    -- print("c.width: " .. tostring(c.width))
    -- print("c.height: " .. tostring(c.height))

    if c.class == nil then
       c.minimized = true
       c:connect_signal("property::class", function ()
         c.minimized = false
         awful.rules.apply(c)
       end)
    end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        if c.floating then
        else
           awful.placement.no_offscreen(c)
        end
    else
      if not c.size_hints.user_position
         and not c.size_hints.program_position
         and not c.maximized then
         awful.placement.centered(c)
      end
    end

    on_maximized_set_or_change(c, false)
end)

client.connect_signal("property::maximized", function(c)
   print("property::maximized received")
   on_maximized_set_or_change(c, true)
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
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
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--awful.mouse.connect_signal("property::screen", function()
--   for s in screen do
--      print("DEBUG: Screen found: " .. tostring(s))
--      print("DEBUG: mytaglist found: " .. tostring(s.mytaglist))
--      print("DEBUG: mytaglist.beautiful found: " .. tostring(s.mytaglist.beautiful))
--      -- s.mywibox.bg = awful.screen.focused() == s and "#ff0000" or "#00ff00"
--   end
--end)

-- Autostart
awful.spawn.with_shell(
       'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
       'xrdb -merge <<< "awesome.started:true";' ..
       'dex -ae Awesome'
       )

awful.spawn.with_shell('customlock start')
