return {
    decode = function(data)
        return JSONDecode(data)
    end,

    encode = function(data)
        return JSONEncode(data)
    end
}