---- module ----

local websocket = {}; do
    function websocket.connect(url: string)
        local data = websocket_connect(url)
        local connection = {}; do
            local callbacks = {};

            function connection:send(message: string)
                -- assertions --

                assert("string" == type(message), `websocket:send: message must be a string, got {type(message)}`)

                -- exports --

                websocket_send(data, message)
            end

            function connection:on(callback)
                -- assertions --

                assert("function" == type(callback), `websocket:on: callback must be a function, got {type(callback)}`)

                -- exports --

                table.insert(callbacks, callback)

                return {
                    disconnect = function()
                        -- assertions --

                        assert("function" == type(callback), `connection:disconnect: callback must be a function, got {type(callback)}`)

                        -- exports --

                        local index = table.find(callbacks, callback)
                        if index then
                            table.remove(callbacks, index)
                        end
                    end
                }
            end

            function connection:close()
                websocket_close(data)
            end

            websocket_onmessage(data, function(...)
                for _, callback in callbacks do
                    callback(...)
                end
            end)
        end

        return connection
    end
end

---- exports ----

return websocket