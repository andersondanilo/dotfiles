local awful = require("awful")

-- autostart
awful.spawn.with_shell("picom --experimental-backends --log-file=/tmp/picom.log --log-level=warn")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("blueman-applet")
