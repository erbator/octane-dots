-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("modules.programs")

hl.on("hyprland.start", function ()
    hl.exec_cmd("awww-daemon")
    -- No fixed `awww img` here: pill restores the last wallpaper picked in its panel.
    -- Hand the Wayland session to systemd user units, then start hyprsunset (pill's night light restarts it)
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP && systemctl --user start hyprsunset")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/quickshell/pill/launch.sh")  -- pill shell
    hl.exec_cmd(os.getenv("HOME") .. "/.local/bin/matugen-wallwatch")       -- recolor kitty + starship on wallpaper change
end)
