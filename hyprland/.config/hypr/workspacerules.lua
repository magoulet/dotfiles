---@diagnostic disable: undefined-global
-- Workspace rules configuration
-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

local main_workspaces = 4
local ext_workspaces = 4

-- Main monitor workspaces
for i = 1, main_workspaces do
  hl.workspace_rule({ workspace = i, monitor = "eDP-1", persistent = false})
end

-- Extended monitor workspaces
for i = main_workspaces + 1, main_workspaces + ext_workspaces do
  hl.workspace_rule({ workspace = i, monitor = "DP-1", persistent = false})
end

