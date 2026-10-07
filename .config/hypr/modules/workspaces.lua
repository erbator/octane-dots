--------------------
---- WORKSPACES ----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Workspaces 1-8 live on the MSI (main), 9 lives on the Dell (left, portrait).

local monitors = require("modules.monitors")

for i = 1, 8 do
    hl.workspace_rule({ workspace = tostring(i), monitor = monitors.msi, default = (i == 1) })
end
hl.workspace_rule({ workspace = "9", monitor = monitors.dell, default = true, persistent = true })

-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
