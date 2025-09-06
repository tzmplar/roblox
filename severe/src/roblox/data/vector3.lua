---- declarations ----

type Vector3 = vector & {
    angle: (v: Vector3, axis: Vector3?) -> number,
    ceil: () -> Vector3,
    floor: () -> Vector3,
    sign: () -> Vector3,
}

local constructor: (x: number, y: number, z: number) -> Vector3

---- reference ----

local reference = {}; do
    function reference:dot(v: Vector3): number
        assert("userdata" == type(v) and getmetatable(v).__vector, `bad argument #1 to 'Vector3:dot' (Vector3 expected, got {type(v)})`)

        return vector.dot(getmetatable(self).__vector, getmetatable(v).__vector)
    end

    function reference:cross(v: Vector3): Vector3
        assert("userdata" == type(v) and getmetatable(v).__vector, `bad argument #1 to 'Vector3:cross' (Vector3 expected, got {type(v)})`)

        local r: vector = vector.cross(getmetatable(self).__vector, getmetatable(v).__vector)
        return constructor(r.x, r.y, r.z)
    end

    function reference:angle(v: Vector3, axis: Vector3?): number
        assert("userdata" == type(v) and getmetatable(v).__vector, `bad argument #1 to 'Vector3:angle' (Vector3 expected, got {type(v)})`)
        assert(axis == nil or ("userdata" == type(axis) and getmetatable(axis).__vector), `bad argument #2 to 'Vector3:angle' (Vector3 expected, got {type(axis)})`)

        return vector.angle(getmetatable(self).__vector, getmetatable(v).__vector, axis and getmetatable(axis).__vector or nil)
    end

    function reference:ceil(): Vector3
        local r: vector = vector.ceil(getmetatable(self).__vector)
        return constructor(r.x, r.y, r.z)
    end

    function reference:floor(): Vector3
        local r: vector = vector.floor(getmetatable(self).__vector)
        return constructor(r.x, r.y, r.z)
    end

    function reference:sign(): Vector3
        local r: vector = vector.sign(getmetatable(self).__vector)
        return constructor(r.x, r.y, r.z)
    end

    function reference:lerp(v: Vector3, alpha: number): Vector3
        assert("userdata" == type(v) and getmetatable(v).__vector, `bad argument #1 to 'Vector3:lerp' (Vector3 expected, got {type(v)})`)
        assert("number" == type(alpha), `bad argument #2 to 'Vector3:lerp' (number expected, got {type(alpha)})`)

        local r: vector = vector.lerp(getmetatable(self).__vector, getmetatable(v).__vector, alpha)
        return constructor(r.x, r.y, r.z)
    end

    function reference:array(): { number }
        local v: vector = getmetatable(self).__vector
        return { v.x, v.y, v.z }
    end
end

---- constructor ----

function constructor(x: number, y: number, z: number): Vector3
    --- assertions ---

    assert("number" == type(x), `bad argument #1 to 'Vector3.new' (number expected, got {type(x)})`)
    assert("number" == type(y), `bad argument #2 to 'Vector3.new' (number expected, got {type(y)})`)
    assert("number" == type(z), `bad argument #3 to 'Vector3.new' (number expected, got {type(z)})`)

    --- userdata ---

    local proxy = newproxy(true); do
        local mt = getmetatable(proxy)

        mt.__vector = vector.create(x, y, z)

        -- metatables --

        function mt:__index(key: string): any
            key = string.lower(key)

            if key == "unit" then
                return vector.normalize(mt.__vector)
            elseif key == "magnitude" then
                return vector.magnitude(mt.__vector)
            end

            return reference[key] or mt.__vector[key]
        end

        function mt:__newindex(key: string, value: any): ()
            key = string.lower(key)

            assert("number" == type(value), `can't assign '{type(value)}' to '{key}' (number expected)`)
            assert(key == "x" or key == "y" or key == "z", `attempt to index Vector3 with '{key}'`)

            local v: vector = mt.__vector
            mt.__vector = vector.create(
                key == "x" and value or v.x,
                key == "y" and value or v.y,
                key == "z" and value or v.z
            )
        end

        function mt:__add(v: Vector3): Vector3
            assert("userdata" == type(v) and getmetatable(v).__vector, `bad argument #1 to 'Vector3 + Vector3' (Vector3 expected, got {type(v)})`)

            local r: vector = mt.__vector + getmetatable(v).__vector
            return constructor(r.x, r.y, r.z)
        end

        function mt:__sub(v: Vector3): Vector3
            assert("userdata" == type(v) and getmetatable(v).__vector, `bad argument #1 to 'Vector3 - Vector3' (Vector3 expected, got {type(v)})`)

            local r: vector = mt.__vector - getmetatable(v).__vector
            return constructor(r.x, r.y, r.z)
        end

        function mt:__mul(n: number | Vector3): Vector3
            if "number" == type(n) then
                local r: vector = mt.__vector * n
                return constructor(r.x, r.y, r.z)
            elseif "userdata" == type(n) and getmetatable(n).__vector then
                local r: vector = vector.mul(mt.__vector, getmetatable(n).__vector)
                return constructor(r.x, r.y, r.z)
            else
                error(`bad argument #1 to 'Vector3 * (number | Vector3)' (number | Vector3 expected, got {type(n)})`, 2)
            end
        end

        function mt:__div(n: number | Vector3): Vector3
            if "number" == type(n) then
                local r: vector = mt.__vector / n
                return constructor(r.x, r.y, r.z)
            elseif "userdata" == type(n) and getmetatable(n).__vector then
                local r: vector = vector.div(mt.__vector, getmetatable(n).__vector)
                return constructor(r.x, r.y, r.z)
            else
                error(`bad argument #1 to 'Vector3 / (number | Vector3)' (number | Vector3 expected, got {type(n)})`, 2)
            end
        end

        function mt:__idiv(n: number | Vector3): Vector3
            if "number" == type(n) then
                local r: vector = vector.idiv(mt.__vector, n)
                return constructor(r.x, r.y, r.z)
            elseif "userdata" == type(n) and getmetatable(n).__vector then
                local r: vector = vector.idiv(mt.__vector, getmetatable(n).__vector)
                return constructor(r.x, r.y, r.z)
            else
                error(`bad argument #1 to 'Vector3 // (number | Vector3)' (number | Vector3 expected, got {type(n)})`, 2)
            end
        end

        function mt:__unm(): Vector3
            local r: vector = -mt.__vector
            return constructor(r.x, r.y, r.z)
        end

        function mt:__eq(v: Vector3): boolean
            assert("userdata" == type(v) and getmetatable(v).__vector, `bad argument #1 to 'Vector3 == Vector3' (Vector3 expected, got {type(v)})`)

            return mt.__vector == getmetatable(v).__vector
        end

        function mt:__tostring(): string
            local v: vector = mt.__vector
            return `{v.x}, {v.y}, {v.z}`
        end
    end

    --- exports ---

    return proxy
end

---- exports ----

return table.freeze {
    one   = constructor(1, 1, 1),
    zero  = constructor(0, 0, 0),
    xAxis = constructor(1, 0, 0),
    yAxis = constructor(0, 1, 0),
    zAxis = constructor(0, 0, 1),
    new   = constructor,
    array = function(array: { number}): Vector3
        assert("table" == type(array), `bad argument #1 to 'Vector3.array' (table expected, got {type(array)})`)

        local x: number = array[1] or array.x
        local y: number = array[2] or array.y
        local z: number = array[3] or array.z

        return constructor(x, y, z)
    end
}
