if not _G.websocket then
    _G.websocket = require("@external/classes/websocket")
end

if not _G.memory then
    _G.memory = require("@external/modules/memory")
end

_G.signal = require("@external/classes/signal")

require("@roblox")