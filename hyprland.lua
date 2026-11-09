local handle = io.popen("hostname")
Hostname = "default"

if handle then
    local result = handle:read("*l")
    handle:close()
    if result then
        Hostname = result:gsub("%s+", "")
    end
end

HyprRoot = os.getenv("HOME") .. "/.config/hypr"

if os.getenv("HYPRLAND_ROOT") then
	HyprRoot = os.getenv("HYPRLAND_ROOT")
end

pcall(dofile, HyprRoot .. "/autoload.lua")
