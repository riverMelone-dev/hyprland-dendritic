-- Use global HyprRoot to extrappolate modules
local modules = HyprRoot .. "/modules"

local p = io.popen('find -L "' .. modules .. '" -name "*.lua" -type f | sort')
if not p then
	return
end

for path in p:lines() do
	local ok, error = pcall(dofile, path)
	if not ok then
		hl.notification.create({
			text = "autoload: " .. path .. "\n" .. tostring(error),
			timeout = 8000,
			icon = "warning",
		})
	end
end

p:close()
