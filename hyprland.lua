local handle = io.popen("hostname")
Hostname = "default"

if handle then
    local result = handle:read("*l")
    handle:close()
    if result then
        Hostname = result:gsub("%s+", "")
    end
end

pcall(dofile, os.getenv("HYPRLAND_ROOT") .. "/autoload.lua")