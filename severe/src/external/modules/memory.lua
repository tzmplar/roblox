---- environment ----

local color = require("@roblox/classes/color")

---- functions ----

local get = function(pointer: any, offset: number, spec: string)
    if "color" == spec and "userdata" == type(pointer) then
        local dword = getmemoryvalue(pointer, offset, "dword")
        return dword and color.dword(dword)
    end

    if "buffer" == spec then
        local q = getmemoryvalue(pointer, offset, "qword")

        return q and buffer.fromstring(string.pack("<I8", q))
    end

    if "vector" == spec then
        local x = getmemoryvalue(pointer,     offset, "float")
        local y = getmemoryvalue(pointer, offset + 4, "float")
        local z = getmemoryvalue(pointer, offset + 8, "float")

        return vector.create(x, y, z)
    end

    return getmemoryvalue(pointer, offset, spec :: any)
end

local set = function(pointer: any, offset: number, spec: string, value: any)
    if "color" == spec and "table" == type(value) and value.dword then
        return setmemoryvalue(pointer, offset, "dword", value:dword())
    end

    if "buffer" == spec and "buffer" == type(value) then
        return setmemoryvalue(pointer, offset, value, "qword")
    end

    if "vector" == spec and "vector" == type(value) then
        local x = value.X or value[1]
        local y = value.Y or value[2]
        local z = value.Z or value[3]

        setmemoryvalue(pointer,     offset, x, "float")
        setmemoryvalue(pointer, offset + 4, y, "float")
        setmemoryvalue(pointer, offset + 8, z, "float")

        return true
    end

    return setmemoryvalue(pointer, offset, value, spec :: any)
end

---- module ----

local memory = {}; do
    function memory.read(pointer: number | any, offset: number | string, spec: string?)
        if "table" == type(pointer) and rawget(pointer, "Data") then
            pointer = pointer.Data
        end

        if "userdata" == type(pointer) then
            assert("number" == type(offset), `memory.read: offset must be a number, got {type(offset)}`)
            assert("string" == type(spec) or not spec, `memory.read: data_type must be a string or nil, got {type(spec)}`)

            return get(pointer, offset, spec :: any)
        end

        if "number" == type(pointer) then
            if "string" == type(offset) then
                return get(pointer_to_user_data(pointer), 0, offset :: any)
            else
                assert("number" == type(offset), `memory.read: offset must be a number or a string, got {type(offset)}`)
                assert("string" == type(spec) or not spec, `memory.read: data_type must be a string or nil, got {type(spec)}`)

                return get(pointer_to_user_data(pointer), offset, spec :: any)
            end 
        end

        return nil
    end

    function memory.write(pointer: number | any, offset: number | string, data_type: string?, value: any)
        if "table" == type(pointer) and rawget(pointer, "Data") then
            pointer = pointer.Data
        end

        if "userdata" == type(pointer) then
            assert("number" == type(offset), `memory.write: offset must be a number, got {type(offset)}`)
            assert("string" == type(data_type) or not data_type, `memory.write: data_type must be a string or nil, got {type(data_type)}`)

            return set(pointer, offset, data_type :: any, value)
        end

        if "number" == type(pointer) then
            if "string" == type(offset) then
                return set(pointer_to_user_data(pointer), 0, offset :: any, value)
            else
                assert("number" == type(offset), `memory.write: offset must be a number or a string, got {type(offset)}`)
                assert("string" == type(data_type) or not data_type, `memory.write: data_type must be a string or nil, got {type(data_type)}`)

                return set(pointer_to_user_data(pointer), offset, data_type :: any, value)
            end
        end

        return nil
    end
end

---- exports ----

return memory