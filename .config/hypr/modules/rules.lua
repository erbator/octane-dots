-- Window and layer rules.
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Workspace rules live in modules/workspaces.lua.


-- Window rules ---------------------------------------------------------------

-- Keep terminals and the file manager fully opaque.
hl.window_rule({ name = "terminal-opacity", match = { class = "^(kitty)$" },           opacity = "1.0 1.0" })
hl.window_rule({ name = "dolphin-opacity",  match = { class = "^(org\\.kde\\.dolphin)$" }, opacity = "1.0 1.0" })

-- Utility windows open floating and centred instead of tiling.
hl.window_rule({
    name  = "float-utilities",
    match = { class = "^(org\\.kde\\.dolphin|pavucontrol|org\\.pulseaudio\\.pavucontrol|blueman-manager|nm-connection-editor|qt6ct|qt5ct|nwg-look|xdg-desktop-portal-gtk|file-roller|org\\.gnome\\.FileRoller|imv|swappy|hyprsysteminfo|org\\.gnome\\.Loupe)$" },
    float = true, center = true, size = { "monitor_w*0.6", "monitor_h*0.65" },
})
hl.window_rule({ name = "float-dialogs", match = { title = "^(Open File|Open Folder|Save As|Save File|Select Folder|File Upload|Choose Files|Preferences|Library|Picture in picture)$" }, float = true, center = true })

-- Polkit prompt / graceful shutdown dialog: float, dim the rest, keep focus.
hl.window_rule({ name = "modal-prompts", match = { class = "^(hyprpolkitagent|org\\.hyprland\\.hyprpolkitagent|hyprshutdown|org\\.hyprland\\.hyprshutdown)$" }, float = true, center = true, dim_around = true, stay_focused = true, pin = true })
hl.window_rule({ name = "portal-picker",  match = { class = "^(xdg-desktop-portal-hyprland)$" }, float = true, center = true, dim_around = true })

-- Browser picture-in-picture: float, pin, put in the corner.
hl.window_rule({ name = "pip", match = { title = "^(Picture-in-Picture)$" }, float = true, pin = true, size = { "monitor_w*0.28", "monitor_h*0.28" }, move = { "monitor_w-window_w-24", "monitor_h-window_h-24" }, no_focus = true })

-- Don't let apps steal fullscreen/maximize state; fixes XWayland drag glitches.
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ name = "fix-xwayland-drags", match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })

-- Keep the screen awake while something is fullscreen (video, presentations).
hl.window_rule({ name = "idle-inhibit-fullscreen", match = { class = ".*" }, idle_inhibit = "fullscreen" })

-- Hyprland-run: float near the bottom-left.
hl.window_rule({ name = "move-hyprland-run", match = { class = "hyprland-run" }, move = "20 monitor_h-120", float = true })


-- Layer rules (bars, menus, notifications) -----------------------------------
hl.layer_rule({ match = { namespace = "^(waybar)$" },                       blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "^(rofi)$" },                         blur = true, ignore_alpha = 0.3, animation = "popin 90%" })
hl.layer_rule({ match = { namespace = "^(swaync-control-center)$" },        blur = true, ignore_alpha = 0.3, animation = "slide" })
hl.layer_rule({ match = { namespace = "^(swaync-notification-window)$" },   blur = true, ignore_alpha = 0.3, animation = "slide" })
hl.layer_rule({ match = { namespace = "^(swayosd)$" },                      blur = true, ignore_alpha = 0.3, animation = "fade" })
hl.layer_rule({ match = { namespace = "^(selection)$" },                    no_anim = true })   -- slurp
hl.layer_rule({ match = { namespace = "^(hyprpicker)$" },                   no_anim = true })
hl.layer_rule({ match = { namespace = "^(logout_dialog)$" },                blur = true, ignore_alpha = 0.3 })
