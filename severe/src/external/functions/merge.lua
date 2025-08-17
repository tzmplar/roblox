
return function(t, into): any
    if not t then return into end
    if not into then return t end

    for key, value in into do
        t[key] = value
    end

    return t
end