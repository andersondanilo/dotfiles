-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Ext library
local cyclefocus = require('lib/cyclefocus')


local terminal_tmux = terminal .. " -e tmux new-session \\; set-option destroy-unattached"

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "F1",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "d", function()  awful.util.spawn("rofi -combi-modi window,drun -show combi") end,
              {description = "open rofi", group = "rofi"}),


    awful.key({ modkey,           }, "n",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "p",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --          {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey }, "l", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey }, "h", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey }, "x", function () awful.util.spawn("customlock lock") end,
              {description = "lock screen", group = "screen"}),

    awful.key({ modkey }, "Tab", function(c)
        cyclefocus.cycle({modifier="Super_L"})
    end),
    -- modkey+Shift+Tab: backwards
    awful.key({ modkey, "Shift" }, "Tab", function(c)
        cyclefocus.cycle({modifier="Super_L"})
    end),
    -- modkey+Shift+Tab: backwards
    awful.key({ modkey, "Shift" }, "Tab", function(c)
        cyclefocus.cycle({modifier="Super_L"})
    end),
    awful.key({ modkey, }, "c", naughty.destroy_all_notifications,
        {description = "clear notifications", group = "awesome"}),
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal_tmux) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "e", awesome.quit,
             {description = "quit awesome", group = "awesome"}),
    -- awful.key({ modkey, "Shift"   }, "e", function () awful.util.spawn("gnome-session-quit --force") end,
    --          {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "r", awesome.restart,
             {description = "restart awesome", group = "awesome"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Multimedia keys
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("pactl -- set-sink-volume 0 +2%") end,
        {description = "raise volume", group = "multimedia keys"}),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("pactl -- set-sink-volume 0 -2%") end,
        {description = "lower volume", group = "multimedia keys"}),
    awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer -D pulse sset Master toggle") end,
        {description = "toggle mute volume", group = "multimedia keys"}),
    awful.key({}, "XF86MonBrightnessUp", function () awful.util.spawn("brightnessctl set 500+") end,
        {description = "raise brightness", group = "multimedia keys"}),
    awful.key({}, "XF86MonBrightnessDown", function () awful.util.spawn("brightnessctl set 500-") end,
        {description = "lower brightness", group = "multimedia keys"}),
    awful.key({}, "XF86AudioPlay", function () awful.util.spawn("playerctl play-pause") end,
        {description = "play/pause", group = "multimedia keys"}),
    awful.key({}, "XF86AudioPause", function () awful.util.spawn("playerctl pause") end,
        {description = "pause", group = "multimedia keys"}),
    awful.key({}, "XF86AudioNext", function () awful.util.spawn("playerctl next") end,
        {description = "next audio", group = "multimedia keys"}),
    awful.key({}, "XF86AudioPrev", function () awful.util.spawn("playerctl previous") end,
        {description = "prev audio", group = "multimedia keys"}),


    awful.key({ }, "Print", function () awful.util.spawn("flameshot gui") end,
      {description = "Take a screenshot of entire screen", group = "screenshot"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift"   }, "h",      function (c) c:move_to_screen(c.screen.index - 1) end,
             {description = "move to left screen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "l",      function (c) c:move_to_screen(c.screen.index + 1) end,
             {description = "move to right screen", group = "client"}),
    awful.key({ modkey,           }, "k",
        function (c)
            c.maximized = true
            c:raise()
        end, {description = "maximize client", group = "client"}),
    awful.key({ modkey,           }, "j",
        function (c)
            c.maximized = false
            c:raise()
        end, {description = "minimize client", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    local nr_key = "#" .. i + 9 -- keycode

    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, nr_key,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = tags[i]
                        if tag then
                           sharedtags.viewonly(tag, screen)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, nr_key,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = tags[i]
                      if tag then
                         sharedtags.viewtoggle(tag, screen)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, nr_key,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, nr_key,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

root.keys(globalkeys)
