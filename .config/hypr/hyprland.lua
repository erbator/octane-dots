-- Hyprland config entry point.
-- Each topic lives in its own file under modules/. Order matters:
-- monitors before workspaces, env before anything that launches programs.
-- https://wiki.hypr.land/Configuring/Start/

require("modules.monitors")     -- monitor layout, refresh rates, rotation
require("modules.workspaces")   -- which workspace lives on which monitor
require("modules.env")          -- environment variables
require("modules.nvidia")       -- NVIDIA env vars + VRR / scanout tweaks
require("modules.permissions")  -- ecosystem permissions (all commented out)
require("modules.appearance")   -- gaps, borders, rounding, blur, shadows
require("modules.animations")   -- curves and animations
require("modules.layouts")      -- dwindle / master / scrolling
require("modules.input")        -- keyboard, mouse, touchpad
require("modules.keybinds")     -- key bindings
require("modules.rules")        -- window and layer rules
require("modules.autostart")    -- programs started at login (wallpaper)
