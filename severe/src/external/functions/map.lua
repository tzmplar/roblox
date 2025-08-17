return function(t, f)
    assert("table" == type(t),    `map(t, callback): expected a table, got {type(t)}`)
    assert("function" == type(f), `map(t, callback): expected a function, got {type(f)}`)

    local result = {}; do
        for k, v in t do
            result[k] = f(v, k, t)
        end
    end

    return result
end