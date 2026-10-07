----------------
---- NVIDIA ----
----------------

-- RTX 3060, nvidia-open driver.
-- See https://wiki.hypr.land/Nvidia/

-- Hardware video decoding (VA-API via libva-nvidia-driver)
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
-- Use the NVIDIA GLX vendor library
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- Run Electron apps (Discord, VS Code, ...) natively on Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.config({
    -- VRR (G-Sync Compatible) only for fullscreen apps; always-on can flicker on NVIDIA
    misc = {
        vrr = 2,
    },

    render = {
        -- Let fullscreen games scan out directly, skipping compositing for lower latency
        direct_scanout = 2,
    },

    opengl = {
        -- Fixes flickering in some apps on NVIDIA
        nvidia_anti_flicker = true,
    },
})
