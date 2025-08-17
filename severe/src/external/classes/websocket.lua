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

            function connection:on(event: string, callback)
                -- assertions --

                assert("string" == type(event), `websocket:on: event must be a string, got {type(event)}`)
                assert("function" == type(callback), `websocket:on: callback must be a function, got {type(callback)}`)

                -- exports --

                callbacks[event] = callbacks[event] or {}
                table.insert(callbacks[event], callback)

                return {
                    disconnect = function()
                        -- assertions --

                        assert("function" == type(callback), `connection:disconnect: callback must be a function, got {type(callback)}`)

                        -- exports --

                        local index = table.find(callbacks[event], callback)
                        if index then
                            table.remove(callbacks[event], index)
                        end
                    end
                }
            end

            function connection:close()
                websocket_close(data)
            end
        end

        return connection
    end
end

---- exports ----

return websocket