-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- NVIDIA-specific variables live in modules/nvidia.lua.

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Qt apps (Dolphin, ...) use the Kvantum style; theme picked in ~/.config/Kvantum/kvantum.kvconfig (Zephyr)
hl.env("QT_STYLE_OVERRIDE", "kvantum")
