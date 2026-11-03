---@diagnostic disable: undefined-global
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})

-- Rules are applied in order and the LAST matching rule wins for a given
-- monitor. 
hl.monitor({
    output   = "DP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})

hl.monitor({
    output   = "desc:LG Electronics LG HDR 4K 0x0002E131",
    mode     = "preferred",
    position = "auto",
    scale    = 1.2,
})

hl.monitor({
    output   = "DP-2",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})
