------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Matched by description so swapping DP ports doesn't break the layout.

local M = {
    dell = "desc:Dell Inc. DELL P2417H CW6Y77CQ57JL",
    msi  = "desc:Microstep MSI G24C4 0x00000DA4",
}

-- Left: Dell P2417H, 60Hz, rotated 270° (portrait, 1080x1920)
hl.monitor({
    output    = M.dell,
    mode      = "1920x1080@60",
    position  = "0x0",
    scale     = 1,
    transform = 3,
})

-- Main (right): MSI G24C4, 144Hz
-- x = Dell's portrait width (1080), y = vertically centered on the Dell ((1920-1080)/2)
hl.monitor({
    output   = M.msi,
    mode     = "1920x1080@143.85",
    position = "1080x420",
    scale    = 1,
})

-- Fallback for anything else that gets plugged in
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

return M
