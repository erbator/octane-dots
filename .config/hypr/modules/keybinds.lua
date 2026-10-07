---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local programs = require("modules.programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(programs.terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")) -- off Super+M (weather)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + U", hl.dsp.window.float({ action = "toggle" })) -- off Super+V (clipboard)
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(programs.menu))     -- off Super+D (launcher)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("brave-origin")) 
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("maximized", "toggle"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through the focused monitor's workspaces with mainMod + scroll
-- scroll_event_delay: ms after a scroll bind fires before the next notch counts (default 300)
hl.config({ binds = { scroll_event_delay = 50 } })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "m-1" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Print: select an area, then annotate it in Satty (Enter copies, Ctrl+S saves; see ~/.config/satty/config.toml)
hl.bind("Print", hl.dsp.exec_cmd([[sh -c 'area=$(slurp -d) && grim -g "$area" - | satty --filename -']]))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- Toggle floating with mainMod + side buttons
-- back button (mouse:275, closer to you): just float
hl.bind(mainMod .. " + mouse:275", hl.dsp.window.float({ action = "toggle" }))
-- forward button (mouse:276, the upper one): float, resize to 60% x 65% of the monitor, and centre
hl.bind(mainMod .. " + mouse:276", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    local win, mon = hl.get_active_window(), hl.get_active_monitor()
    if not (win and win.floating and mon) then return end
    local w, h = mon.width / mon.scale, mon.height / mon.scale
    if mon.transform % 2 == 1 then w, h = h, w end -- rotated monitor
    hl.dispatch(hl.dsp.window.resize({ x = math.floor(w * 0.6), y = math.floor(h * 0.65) }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Media keys (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

------------------
------ PILL ------
------------------

-- Panel binds carried over from QS-DFMID26 (dynamic-glacier), pointed at the
-- matching pill surfaces. Panels pill has no equivalent for are left out.
local function pill(call)
    return hl.dsp.exec_cmd("qs -c pill ipc call pill " .. call)
end

hl.bind(mainMod .. " + D",      pill('launcher ""'))
hl.bind(mainMod .. " + V",      pill('clipboard ""'))
hl.bind(mainMod .. " + W",      pill('wallpaper ""'))
hl.bind(mainMod .. " + Escape", pill('power ""'))
hl.bind(mainMod .. " + M",      pill('page "" weather'))
hl.bind(mainMod .. " + I",      pill('page "" theme'))
hl.bind(mainMod .. " + R",      pill('toggleHide'))

-- Swap the bar between Waybar and pill (~/.local/bin/bar-toggle)
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/bar-toggle"))

-- Lock: pill's lock script (Quickshell lockscreen; lockMethod in its settings).
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/quickshell/pill/scripts/lock.sh"), { locked = true })

-- Tapping SUPER alone (pressed and released with no other key) pins the island
-- down on the focused monitor; tap again to lift it. Unlike the surface calls,
-- peek does not fall back to the focused monitor on "", so pass it explicitly.
hl.bind(mainMod .. " + SUPER_L", pill([[peek "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"]]), { release = true })
