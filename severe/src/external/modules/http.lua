return {
    get = function(settings, callback)
        assert("table" == type(settings), `http.get: settings must be a table, got {type(settings)}`)
        assert("function" == type(callback), `http.get: callback must be a function, got {type(callback)}`)

        spawn(function()
            return callback(httpget(unpack(settings)))
        end)
    end,

    post = function(settings, callback)
        assert("table" == type(settings), `http.get: settings must be a table, got {type(settings)}`)
        assert("function" == type(callback), `http.get: callback must be a function, got {type(callback)}`)

        spawn(function()
            return callback(httpget(unpack(settings)))
        end)
    end
}