---- definitions ----

_G.Signal 	 = require("@external/classes/signal")
_G.websocket = require("@external/classes/websocket")
_G.memory 	 = require("@external/modules/memory")

---- functions ----

_G.print = function(...)
	local args, count = { ... }, select("#", ...)
	local output = ""

	for i = 1, count do
		local v = args[i]

		if type(v) == "table" then
			if v.Name and v.Data then
				output = output .. v.Name .. " | "
			end
		elseif type(v) == "userdata" then
			output = output .. getname(v) .. " | "
		end

		local str = tostring(v)
		if type(str) ~= "string" then
			error("'tostring' must return a string - print function")
		end

		output = output .. str .. " "
	end

	return print(output)
end

_G.warn = function(...)
	local args, count = { ... }, select("#", ...)
	local output = ""

	for i = 1, count do
		local v = args[i]

		if type(v) == "table" then
			if v.Name and v.Data then
				output = output .. v.Name .. " | "
			end
		elseif type(v) == "userdata" then
			output = output .. getname(v) .. " | "
		end

		local str = tostring(v)
		if type(str) ~= "string" then
			error("'tostring' must return a string - warn function")
		end

		output = output .. str .. " "
	end

	return warn(output)
end

---- roblox ----

return require("@roblox")