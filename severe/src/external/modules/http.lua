return {
    get = function(settings, callback)
        assert("table" == type(settings), `http.get: settings must be a table, got {type(settings)}`)
        assert("function" == type(callback), `http.get: callback must be a function, got {type(callback)}`)

        if callback then
            return spawn(function()
                return callback(httpget(unpack(settings)))
            end)
        else
            return httpget(unpack(settings))
        end
    end,

    post = function(settings, callback)
        assert("table" == type(settings), `http.get: settings must be a table, got {type(settings)}`)
        assert("function" == type(callback), `http.get: callback must be a function, got {type(callback)}`)

        if callback then
            return spawn(function()
                return callback(httppost(unpack(settings)))
            end)
        else
            return httppost(unpack(settings))
        end
    end
}